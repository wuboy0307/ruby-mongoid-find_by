ENV["RAILS_ENV"], ENV["RACK_ENV"] = "test", "test"
$:.unshift(File.expand_path("../../", __FILE__))

require "simplecov"
SimpleCov.start

require "mongoid/finders/find_by"
Mongoid.load!(File.expand_path("../../config/mongoid.yml", __FILE__), :test)
module Mongoid::SpecHelpers
  class << self
    def random_class
      random(10).capitalize.to_sym
    end

    def random(len)
      (0..len).map { ('a'..'z').to_a[rand(26)] }.join.capitalize
    end
  end
end

if ENV["CI"]
  Mongoid.configure do |config|
    config.connect_to("travis-#{Process.pid}")
  end
end

module Rails
  class Application
    # 0
  end
end

module FindBy
  class Application < Rails::Application
    # 1
  end
end

RSpec.configure do |config|
  config.before(:each) do
    Mongoid.purge!
  end
end
