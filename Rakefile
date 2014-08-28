
Bundler.require(:default, :development, :test)

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "tests"
  t.test_files = FileList['tests/test*.rb']
  t.verbose = true
end


task :default => [] # Just in case it hasn't already been set
