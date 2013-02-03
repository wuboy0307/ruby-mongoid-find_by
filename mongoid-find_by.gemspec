$:.unshift(File.expand_path('../lib', __FILE__))
require "mongoid/finders/find_by/version"

Gem::Specification.new do |spec|
  spec.homepage = "https://github.com/envygeeks/mongoid-find_by"
  spec.summary = "Add ActiveRecord like finders to Mongoid."
  spec.required_ruby_version = '>= 1.9.3'
  spec.name = "mongoid-find_by"
  spec.has_rdoc = false
  spec.license = "MIT"
  spec.require_paths = ["lib"]
  spec.authors = "Jordon Bedwell"
  spec.email = "envygeeks@gmail.com"
  spec.version = Mongoid::Finders::FindBy::VERSION
  spec.add_runtime_dependency("mongoid", "~> 3.0.19")
  spec.add_development_dependency("rake", "~> 10.0.3")
  spec.add_development_dependency("rspec", "~> 2.12.0")
  spec.add_development_dependency("shoulda-matchers", "~> 1.4.2")
  spec.files = %w(Readme.md MIT-License Rakefile Gemfile) + Dir.glob('lib/**/*')
  spec.description = "'Add ActiveRecord like finders to your Mongoid install."
end
