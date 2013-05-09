ENV["RAILS_ENV"], ENV["RACK_ENV"] = "test", "test"
$:.unshift(File.expand_path("../../", __FILE__))

unless %W(no false).include?(ENV["COVERAGE"])
  require "simplecov"
  require "coveralls"

  module Coveralls
    NoiseBlacklist = [
      "[Coveralls] Using SimpleCov's default settings.".green,
      "[Coveralls] Set up the SimpleCov formatter.".green,
      "[Coveralls] Outside the Travis environment, not sending data.".yellow
    ]

    def puts(message)
      # Only prevent the useless noise on our terminals, not inside of the Travis or Circle CI.
      unless NoiseBlacklist.include?(message) || ENV["TRAVIS"] == "true" || ENV["CI"] == "true"
        $stdout.puts message
      end
    end
  end

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
        Coveralls::SimpleCov::Formatter
  ]

  Coveralls.noisy = true
  SimpleCov.start do
    add_filter "/spec/"
  end
end

require "mongoid/finders/find_by"

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
    Mongoid::IdentityMap.clear
  end

  config.after(:suite) do
    Mongoid::Threaded.sessions[:default].drop
  end
end

Mongoid.load!(File.expand_path("../../config/mongoid.yml", __FILE__), :test)
