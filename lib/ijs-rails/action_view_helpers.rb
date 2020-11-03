# frozen_string_literal: true

module IJSRails
  # Helper methods to include into action view.
  #
  module ActionViewHelpers
    extend ActiveSupport::Concern

    # Render an HTML <script> tag containing the compiled script.
    #
    # @param  script  [String] The name of the inline script to render.
    # @param  options [Hash]   The options to pass to the compiler.
    # @return         [String] An HTML <script> tag containing the compiled script.
    #
    def render_ijs(script, options = {})
      tag_options = options.dup
      script_options = tag_options.slice!(:async, :defer, :nonce, :type)

      javascript_tag(tag_options) do
        IJSRails::Script.new(script, script_options).compiled.html_safe
      end
    end
  end
end
