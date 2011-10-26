require 'neology/graph_mixin/graph_mixin'
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

    def inner_relationship
      @inner_inner_relationship
    end

    def self.included(base)
      base.extend Neology::RelationshipMixin::ClassMethods
      base.extend Neology::PropertyMixin::ClassMethods
    end

  end

end