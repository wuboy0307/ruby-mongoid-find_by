Gem::Specification.new do |spec|
  spec.required_ruby_version = '>= 1.9.3'
  spec.name = "mongoid-find_by"
  spec.has_rdoc = false
  spec.license = "MIT"
  spec.version = 0.3
  spec.require_paths = ["lib"]
  spec.authors = "Jordon Bedwell"
  spec.email = "envygeeks@gmail.com"
  spec.add_runtime_dependency("mongoid")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("rspec")
  spec.add_development_dependency("shoulda-matchers")
  spec.summary = "Add ActiveRecord like finders to Mongoid."
  spec.homepage = "https://github.com/envygeeks/mongoid-find_by"
  spec.files = %w(Readme.md License Rakefile Gemfile) + Dir.glob('lib/**/*')
  spec.description = "'Add ActiveRecord like finders to your Mongoid install."
end
