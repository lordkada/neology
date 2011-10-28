require 'neology/relationship_index_mixin/relationship_index_mixin'
require 'neology/relationship_property_mixin/relationship_property_mixin'
require 'neology/relationship_mixin/class_methods'

module Neology

  module RelationshipMixin

    include Neology::RelationshipPropertyMixin

    attr_reader :start_node
    attr_reader :end_node

    def initialize inner_relationship, start_node, end_node
      @inner_relationship = inner_relationship
      @start_node         = start_node
      @end_node           = end_node
    end

    def inner_relationship
      @inner_relationship
    end

    def id
      RestUtils.get_id @inner_relationship
    end

    def del
      $neo_server.delete_relationship(inner_relationship)
      $neo_server.delete_relationship_from_index(self.class._index_name, inner_relationship) if self.class.respond_to? :delete_relationship_index
    end

    def self.included(base)

      base.instance_eval do
        class << self
          alias_method :old_new, :new
        end
      end

      base.extend Neology::RelationshipMixin::ClassMethods
      base.extend Neology::RelationshipIndexMixin::ClassMethods
      base.extend Neology::RelationshipPropertyMixin::ClassMethods
    end

  end

end