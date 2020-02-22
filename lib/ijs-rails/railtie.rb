# frozen_string_literal: true

raise 'ijs-rails is an extension for Rails.' unless defined?(Rails::Railtie)

module IJSRails
  # The main entry point which integrates this gem into the Rails system.
  #
  class Railtie < Rails::Railtie
    initializer 'inline_js.set_configs' do |app|
      app.configure do
        config.inline_js = ActiveSupport::OrderedOptions.new
      end
    end
  end
end
