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

# Obey #{gem}_GIT_BRANCH or #{gem}_DIR settings unless #{gem}_DEPLOY is set
#def custom_require(name, version, opts = {})
#  if ENV["#{name.upcase}_GIT_BRANCH"]
#    opts[:git] = "git@github.com:lendkey/#{name}.git"
#    opts[:branch] = ENV["#{name.upcase}_GIT_BRANCH"]
#  elsif gem_dir = ENV["#{name.upcase}_DIR"]
#    opts[:path] = gem_dir
#  end  unless ENV["#{name.upcase}_DEPLOY"]
#  gem name, version, opts
#end

# Remember to register custom gems in config/deploy.rb
#custom_require 'reporting_exporter', '>= 1.0.0'


# load local Gemfile
local_gemfile = File.expand_path '~/.Gemfile'
if File.exist? local_gemfile
  eval File.read(local_gemfile)
end
