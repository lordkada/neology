require 'neology/property_mixin/property_mixin'
require 'neology/rels_mixin/rels_mixin'
require 'neology/has_mixin/class_methods'
require 'neology/index_mixin/index_mixin'
require 'neology/node_mixin/class_methods'

module Neology

  module NodeMixin

    include Neology::PropertyMixin
    include Neology::RelsMixin

    def initialize inner_node
      @inner_node= inner_node
    end

    def inner_node
      @inner_node
    end

    def id
      RestUtils.get_id @inner_node
    end

    def == (other)
      inner_node == other.inner_node if other
    end

    def del
      $neo_server.delete_node!(inner_node)
      $neo_server.delete_node_from_index(self.class._index_name, inner_node) if self.class.respond_to? :delete_node_from_index
    end

    def self.included(base)

      base.instance_eval do
        class << self
          alias_method :old_new, :new
        end
      end

      base.extend Neology::NodeMixin::ClassMethods
      base.extend Neology::PropertyMixin::ClassMethods
      base.extend Neology::RelsMixin::ClassMethods
      base.extend Neology::HasMixin::ClassMethods
      base.extend Neology::IndexMixin::ClassMethods

    end

  end

end