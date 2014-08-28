require 'bundler'
Bundler.require(:default, :development, :test)
Bundler::GemHelper.install_tasks

require 'rdoc/task'
#require 'rspec/core/rake_task'
#require 'cucumber/rake/task'

Rake::RDocTask.new(:rdoc => 'rdoc',
                   :clobber_rdoc => 'rdoc:clobber',
                   :rerdoc => 'rdoc:force') do |task|
  task.title = 'Heimdall'
  task.rdoc_dir = 'doc'
  task.options << '--line-numbers' << 'inline-source'
  task.rdoc_files.include 'app/**/*.rb'
end

#RSpec::Core::RakeTask.new :rspec do |task|
#  task.rspec_opts = '--format documentation'
#end
#task :default => :rspec
#
#Cucumber::Rake::Task.new do |task|
#  task.cucumber_opts = '--format pretty'
#end
#
