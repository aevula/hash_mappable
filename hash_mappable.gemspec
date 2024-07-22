# frozen_string_literal: true

require_relative 'lib/hash_mappable/version'

Gem::Specification.new do |spec|
  spec.name = 'hash_mappable'
  spec.version = HashMappable::VERSION

  spec.authors = ['@aevula']
  spec.email = ['aevula@mail.ru']

  spec.summary = 'Customizable Hash-like Object data fetcher'
  spec.homepage = 'https://github.com/aevula/hash_mappable'

  spec.licenses = ['MIT']

  spec.required_ruby_version = '>= 3.3'

  spec.files = Dir['CHANGELOG.md', '{examples,lib,spec}/**/*', 'LICENSE.md', 'Rakefile', 'README.md']
  spec.require_paths = ['lib']

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = "#{spec.homepage}/blob/master/CHANGELOG.md"
  spec.metadata['rubygems_mfa_required'] = 'true'
end
