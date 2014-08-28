# -*- encoding: utf-8 -*-
require File.expand_path('../lib/heimdall/version', __FILE__)

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "heimdall"
  spec.version       = Heimdall::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ['Mike Canann']
  spec.email         = ['mikecanann@gmail.com']
  spec.summary       = %q{SSH connection menu}
  spec.description   = %q{Provides server and usernames, and creats ssh terminl connections.}
  spec.homepage      = "http://github.com/mikecanann/Heimdall"
  spec.license       = "GPL3"

  spec.files         = ['lib/heimdall.rb']
  spec.executables   = ['heimdall']
  spec.test_files    = ['tests/test_heimdall.rb']
  spec.require_paths = ["lib"]
end

