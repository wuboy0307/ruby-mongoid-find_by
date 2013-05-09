require "mongoid"

module Mongoid::Finders::FindBy
  extend ActiveSupport::Concern

  included do
    class << self
      def cache_find_by_method(meth, finder, attrs)
        singleton_class.class_eval <<-RUBY
          def #{meth}(#{attrs.join(",")})
            #{finder}(#{attrs.inject([]) { |o, a| o << ":#{a} => #{a}" }.join(",")})
          end
        RUBY
      end

      def method_missing(meth, *args)
        if meth =~ /\A(find_(?:all_)?by)_((?:[a-z0-9]_?)+)\Z/
          finder, attrs = $1.dup, $2.split('_and_')
          super if attrs.any? { |a| !fields.has_key?(a) }

          finder = (finder =~ /\Afind_all/ ? "where" : "find_by")
          cache_find_by_method(meth, finder, attrs)
          send(meth, *args)
        else
          super
        end
      end
    end
  end
end

Mongoid::Document.send(:include, Mongoid::Finders::FindBy)
