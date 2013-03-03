$:.unshift(File.expand_path('../lib', __FILE__))
require "mongoid/finders/find_by/version"

Gem::Specification.new do |s|
  s.homepage = "https://github.com/envygeeks/mongoid-find_by"
  s.summary = "Add ActiveRecord like finders to Mongoid."
  s.name = "mongoid-find_by"
  s.license = "MIT"
  s.require_paths = ["lib"]
  s.authors = "Jordon Bedwell"
  s.email = "envygeeks@gmail.com"
  s.version = Mongoid::Finders::FindBy::VERSION
  s.add_runtime_dependency("mongoid", "~> 3.1.2")
  s.add_development_dependency("rake", "~> 10.0.3")
  s.add_development_dependency("rspec", "~> 2.12")
  s.description = "Add ActiveRecord like finders to your Mongoid install."
  s.files = %w(Readme.md MIT-License Rakefile Gemfile) + Dir.glob("lib/**/*")
end
