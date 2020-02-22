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
      type = options.delete(:type)
      compiled_script = IJSRails::Script.new(script, options).compiled.html_safe
      content_tag(:script, compiled_script, type: type)
    end
  end
end
