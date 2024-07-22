# frozen_string_literal: true

source 'https://rubygems.org'

group :development, :test do
  gem 'byebug'
  gem 'debug'

  gem 'rake'

  gem 'rspec'
end

group :development do
  gem 'magic_frozen_string_literal', require: false

  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'rspec_junit_formatter', require: false
  gem 'simplecov', require: false
end

gemspec
