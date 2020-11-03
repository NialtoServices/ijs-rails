# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'bundler'
require 'combustion'

Combustion.initialize! :action_controller, :action_view

# Prevent database truncation if the environment is production.
abort 'The Rails environment is running in production mode!' if Rails.env.production?

require 'rspec/rails'
require 'spec_helper'

# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in spec/support/ and its subdirectories.
# Files matching `spec/**/*_spec.rb` are run as spec files by default.
# This means that files in spec/support that end in _spec.rb will both be required and run as specs, causing the specs
# to be run twice.
# It is recommended that you do not name files matching this glob to end with _spec.rb.
# You can configure this pattern with the --pattern option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes.
# It has the downside of increasing the boot-up time by auto-requiring all files in the support directory.
# Alternatively, in the individual `*_spec.rb` files, manually require only the support files necessary.
#
Dir[Rails.root.join('../support/**/*.rb')].sort.each { |f| require f }
