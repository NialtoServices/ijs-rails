# frozen_string_literal: true

raise 'ijs-rails is an extension for Rails.' unless defined?(Rails::Railtie)

module IJSRails
  # The railtie which ties the gem into the Rails system.
  #
  class Railtie < Rails::Railtie
    initializer 'inline_js.set_configs' do |app|
      app.configure do
        config.inline_js = ActiveSupport::OrderedOptions.new
        config.inline_js.path = Rails.root.join('app/javascript/inline')
        config.inline_js.cache_path = Rails.root.join('tmp/ijs')
        config.inline_js.isolate_scripts = true
      end
    end
  end
end
