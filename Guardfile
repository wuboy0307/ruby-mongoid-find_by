guard :rspec do
  watch("spec/rspec/helper.rb") { "spec" }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |file| "spec/lib/#{file[1]}_spec.rb" }
end
