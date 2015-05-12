# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deku/version'

Gem::Specification.new do |spec|
  spec.name          = 'deku'
  spec.version       = Deku::VERSION
  spec.authors       = ['Dirk Gadsden']
  spec.email         = ['dirk@dirk.to']
  spec.summary       = 'Ruby interface to Deku JavaScript library'
  spec.homepage      = 'https://github.com/dirk/deku.rb'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|bin)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'therubyracer', '~> 0.12.2'

  spec.add_dependency 'commonjs', '~> 0.2.7'
end
