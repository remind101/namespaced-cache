# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'namespaced_cache/version'

Gem::Specification.new do |spec|
  spec.name          = 'namespaced-cache'
  spec.version       = NamespacedCache::VERSION
  spec.authors       = ['Eric J. Holmes']
  spec.email         = ['eric@ejholmes.net']
  spec.description   = %q{An ActiveSupport::Cache implementation for prefixing.}
  spec.summary       = %q{An ActiveSupport::Cache implementation for prefixing.}
  spec.homepage      = 'https://github.com/remind101/namespaced-cache'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>= 3.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.4.2'
  spec.add_development_dependency 'rspec', '~> 3.1.0'
end
