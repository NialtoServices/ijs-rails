# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'ijs-rails/constants'

Gem::Specification.new do |spec|
  spec.name          = 'ijs-rails'
  spec.version       = IJSRails::VERSION
  spec.authors       = ['Nialto Services']
  spec.email         = ['support@nialtoservices.co.uk']

  spec.summary       = 'Inline JavaScript helper for Ruby on Rails.'
  spec.homepage      = 'https://github.com/nialtoservices/ijs-rails'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.metadata['yard.run'] = 'yri'

  spec.add_runtime_dependency 'actionview',    '>= 6', '< 8'
  spec.add_runtime_dependency 'activesupport', '~> 6.0'
  spec.add_runtime_dependency 'uglifier',      '~> 4.2'

  spec.add_development_dependency 'bundler',             '~> 2.1'
  spec.add_development_dependency 'combustion',          '~> 1.1'
  spec.add_development_dependency 'guard-rspec',         '~> 4.7'
  spec.add_development_dependency 'rake',                '~> 13.0'
  spec.add_development_dependency 'rspec',               '~> 3.9'
  spec.add_development_dependency 'rspec-html-matchers', '~> 0.9.2'
  spec.add_development_dependency 'rspec-rails',         '~> 3.9'
  spec.add_development_dependency 'rubocop',             '~> 0.80.0'
  spec.add_development_dependency 'yard',                '~> 0.9.24'
end
