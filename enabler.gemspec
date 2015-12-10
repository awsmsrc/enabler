# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enabler/version'

Gem::Specification.new do |spec|
  spec.name          = 'enabler'
  spec.version       = Enabler::VERSION
  spec.authors       = ['Luke Roberts']
  spec.email         = ['email@luke-roberts.co.uk']
  spec.summary       = 'Enable features'
  spec.description   = 'Enable features'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'redis'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'mock_redis'
end
