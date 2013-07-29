module RSpec
  module Helpers
    module Mongoid
      module FindByHelpers
        def random_class
          random(10).capitalize.to_sym
        end

        def random(len)
          (0..len).map { ('a'..'z').to_a[rand(26)] }.join.capitalize
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Helpers::Mongoid::FindByHelpers
end
