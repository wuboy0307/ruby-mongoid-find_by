require 'rubygems/package_task'
require 'rspec/core/rake_task'

task :default => [:spec]
desc 'Run rspec tests'
RSpec::Core::RakeTask.new do |task|
  task.pattern = "spec/**/*_spec.rb"
end

desc 'Package gem'
Gem::PackageTask.new(eval(IO.read('mongoid-find_by.gemspec'))) do |pkg|
  pkg.need_tar, pkg.need_zip = true
end
