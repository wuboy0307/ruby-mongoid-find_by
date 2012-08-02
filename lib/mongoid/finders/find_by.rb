require 'mongoid'

module Mongoid::Finders::FindBy
  extend ActiveSupport::Concern
  VERSION = 0.1

  included do
    class << self
      def method_missing(meth, *args)
        if meth =~ /\A(find_(?:all_)?by)_((?:[a-z0-9]_?)+)\Z/
          mongoid_meth, attrs = $1.dup, $2.split('_and_')
          attrs.each do |attr|
            unless fields.has_key?(attr)
              super
            end
          end

          mongoid_meth = (mongoid_meth =~ /\Afind_all/ ? 'where' : 'find_by')
          singleton_class.class_eval <<-SOURCE
            def #{meth}(#{attrs.join(', ')})
              #{mongoid_meth}(#{attrs.inject([]) { |obj, attr| obj << "#{attr}: #{attr}" }.join(', ')})
            end
          SOURCE

          return send(meth, *args)
        end

        super
      end
    end
  end
end

Mongoid::Document.send(:include, Mongoid::Finders::FindBy)
