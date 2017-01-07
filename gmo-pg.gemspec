# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gmo-pg/version'

Gem::Specification.new do |spec|
  spec.name          = 'gmo-pg'
  spec.version       = GMO::PG::VERSION
  spec.authors       = %w{ kissy2go }
  spec.email         = %w{ kissy2go@gmail.com }

  spec.summary       = 'Ruby bindings for GMO-PG Multi-Payment Service'
  spec.description   = 'GMO-PG is No.1 Payment Gateway in Japan. See https://www.gmo-pg.com for details.'
  spec.homepage      = 'https://github.com/kissy2go/gmo-pg'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^spec/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %{ lib }

  spec.required_ruby_version = Gem::Requirement.new('>= 2.2.0')
end
