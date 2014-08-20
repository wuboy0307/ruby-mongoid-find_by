$:.unshift(File.expand_path('../lib', __FILE__))
require "mongoid/finders/find_by/version"

Gem::Specification.new do |spec|
  spec.homepage = "https://github.com/envygeeks/mongoid-find_by"
  spec.summary = "Add ActiveRecord like finders to Mongoid."
  spec.name = "mongoid-find_by"
  spec.license = "MIT"
  spec.require_paths = ["lib"]
  spec.authors = "Jordon Bedwell"
  spec.email = "envygeeks@gmail.com"
  spec.version = Mongoid::Finders::FindBy::VERSION
  spec.files = %w(Readme.md License Rakefile Gemfile) + Dir.glob("lib/**/*")
  spec.description = "Add ActiveRecord like finders to your Mongoid install."

  spec.add_runtime_dependency("mongoid", ">= 3.1.4", "< 4.1")
  spec.add_development_dependency("rspec", "~> 3.0")
  spec.add_development_dependency("envygeeks-coveralls", "~> 0.2")
  spec.add_development_dependency("luna-rspec-formatters", "~> 1.2")
end
