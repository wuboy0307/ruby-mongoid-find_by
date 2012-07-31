require 'mongoid'

module Mongoid::Finders::FindBy
  extend ActiveSupport::Concern
  VERSION = 0.1

  included do
    def self.method_missing(meth, *args)
      if meth =~ /\A(find_(?:all_)?by)_((?:[a-z0-9]_?)+)\Z/
        attrs = ($2.dup).split('_and_')
        attrs.each do |attr|
          unless fields.has_key?(attr)
            super
          end
        end

        mongoid_meth = ($1.dup =~ /\Afind_all/ ? 'where' : 'find_by')
        class_eval(<<-SOURCE) unless methods.include?(meth)
          define_singleton_method(:#{ meth }) do |#{ attrs.join(', ') }|
            #{mongoid_meth}(#{attrs.inject([]) { |obj, attr| obj << "#{attr}: #{attr}" }.join(', ')})
          end
        SOURCE

        return send(meth, *args)
      end

      super
    end
  end
end

Mongoid::Document.send(:include, Mongoid::Finders::FindBy)
