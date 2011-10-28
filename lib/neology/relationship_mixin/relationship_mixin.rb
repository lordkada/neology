require 'neology/relationship_index_mixin/class_methods'
require 'neology/relationship_property_mixin/class_methods'
require 'neology/relationship_mixin/class_methods'

module Neology

  module RelationshipMixin

    attr_reader :start_node
    attr_reader :end_node

    def initialize inner_relationship, start_node, end_node
      @inner_relationship = inner_relationship
      @start_node         = start_node
      @end_node           = end_node
    end

    def inner_node
      @inner_relationship
    end

    def id
      RestUtils.get_id @inner_relationship
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