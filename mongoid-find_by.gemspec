Gem::Specification.new do |spec|
  spec.license = 'MIT'
  spec.name = 'mongoid-find_by'
  spec.has_rdoc = false
  spec.version = 0.3
  spec.require_paths = ['lib']
  spec.add_runtime_dependency('mongoid')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('shoulda-matchers')
  spec.authors = 'Jordon Bedwell'
  spec.email = 'jordon@envygeeks.com'
  spec.homepage = 'https://github.com/envygeeks/mongoid-find_by'
  spec.summary = 'Add ActiveRecord like find_by and find_all_by to Mongoid.'
  spec.description = 'Add ActiveRecord like find_by and find_all_by to your Mongoid install.'
  spec.files = Dir.glob('lib/**/*') + Dir.glob('spec/**/*')
  spec.files+= %w(Readme.md License Rakefile Gemfile)
  spec.required_ruby_version = '>= 1.9.3'
end
