ENV["RAILS_ENV"], ENV["RACK_ENV"] = "test", "test"
require_relative "../support/simplecov"
require "luna/rspec/formatters/checks"
require "mongoid/finders/find_by"
require "rspec/expect_error"

Mongoid.load!(File.expand_path("../../config/mongoid.yml", __FILE__), :test)
if ENV["CI"]
  Mongoid.configure do |config|
    config.connect_to("travis-#{Process.pid}")
  end
end

RSpec.configure do |config|
  config.before(:each) do
    Mongoid.purge!
    Mongoid::IdentityMap.clear
  end

  config.after(:suite) do
    Mongoid::Threaded.sessions[:default].drop
  end
end

Dir[File.expand_path("../../support/**/*.rb", __FILE__)].each do |f|
  require f
end
