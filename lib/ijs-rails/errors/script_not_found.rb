# frozen_string_literal: true

module IJSRails
  # Raised when attempting to use an inline script that can't be found.
  #
  class ScriptNotFound < BaseError
    # @return [String] The name of the script.
    #
    attr_reader :script

    # Create a new instance of this error.
    #
    # @param script [String] The name of the script.
    #
    def initialize(script)
      @script = script
    end

    # @return [String] The error message.
    #
    def to_s
      "The inline script '#{script}' could not be found."
    end
  end
end
