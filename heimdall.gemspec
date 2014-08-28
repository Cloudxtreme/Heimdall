# -*- encoding: utf-8 -*-
require File.expand_path('../lib/heimdall/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'heimdall'
  s.version     = Heimdall::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Mike Canann']
  s.email       = ['mikecanann@gmail.com']
  s.homepage    = 'http://github.com/mikecanann/Heimdall'
  s.summary     = 'SSH connection menu'
  s.description = 'Provides server and usernames, and creats ssh terminl connections'

#  s.add_dependency 'nokogiri', '1.5.4'                      # An HTML, XML, SAX, and Reader parser

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- {spec,features}/*`.split("\n")
  s.require_path = 'lib'
end
