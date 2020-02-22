# frozen_string_literal: true

module IJSRails
  # Represents an inline script stored in the inline scripts directory.
  #
  class Script
    # @return [String] The name of a script within the inline scripts directory.
    #
    attr_reader :script

    # @return [Hash] The options to use when compiling the script.
    #
    attr_reader :options

    # Create a new `Script` instance.
    #
    # @param script  [String] The name of a script within the inline scripts directory.
    # @param options [Hash]   The options to use when compiling the script.
    #
    def initialize(script, options = {})
      @script = script
      @options = options

      raise IJSRails::ScriptNotFound, script unless File.file?(file_path)
    end

    # @return [String] The path to the script file.
    #
    def file_path
      @file_path ||= File.join(Rails.application.config.inline_js.path, "#{script}.js")
    end

    # @return [String] The fingerprint representing the script and current options.
    #
    def fingerprint
      @fingerprint ||= Zlib.crc32(options.to_json + File.read(file_path)).to_s
    end

    # @return [String] The path to the compiled script in the cache directory.
    #
    def cache_file_path
      @cache_file_path ||= File.join(Rails.application.config.inline_js.cache_path, "#{script}-#{fingerprint}.min.js")
    end

    # @return [Boolean] `true` when the cache contains a copy of the compiled script, `false` otherwise.
    #
    def cached?
      File.file?(cache_file_path)
    end

    # @return [Boolean] `true` when the script should be wrapped isolated in an anonymous function, `false` otherwise.
    #
    def isolate?
      if options.key?(:isolate)
        options[:isolate]
      else
        Rails.application.config.inline_js.isolate_scripts
      end
    end

    # Compile the script and cache it for reuse.
    #
    # @return [String] The contents of the compiled script.
    #
    def compile!
      # Compile the script.
      script = File.read(file_path)
      script = "!function(){\n#{script}\n}();" if isolate?
      script = Uglifier.compile(script, options.except(:isolate))

      # Create the cache directory for the script (unless it already exists).
      cache_directory_path = File.dirname(cache_file_path)
      FileUtils.mkdir_p(cache_directory_path) unless File.directory?(cache_directory_path)

      # Write the script to the determined cache file path.
      File.write(cache_file_path, script)

      script
    end

    # Retrieve the compiled script either from the cache or by compiling it.
    #
    # @return [String] The contents of the compiled script.
    #
    def compiled
      return File.read(cache_file_path) if cached?

      compile!
    end
  end
end
