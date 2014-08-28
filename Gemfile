# -*- coding: utf-8 -*-

source 'https://rubygems.org'

gemspec

group :development do
#  gem 'awesome_print', '~> 1.1.0'
#  gem 'debugger', '~> 1.6.1'
end

group :test do
#  gem 'factory_girl', '~> 2.6.4'
end

# Remember to register custom gems in config/deploy.rb
#custom_require 'reporting_exporter', '>= 1.0.0'

gem 'rake',   '10.3.2'

# load local Gemfile
local_gemfile = File.expand_path '~/.Gemfile'
if File.exist? local_gemfile
  eval File.read(local_gemfile)
end
