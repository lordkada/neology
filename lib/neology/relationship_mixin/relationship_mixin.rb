require 'neology/graph_mixin/graph_mixin'
require 'neology/relationship_mixin/class_methods'

module Neology

  module RelationshipMixin

    attr_reader :source_wrapper
    attr_reader :destination_wrapper

    def initialize inner_relationship, source_wrapper, destination_wrapper
      @inner_relationship= inner_relationship
      @source_wrapper     = source_wrapper
      @destination_wrapper= destination_wrapper
    end

    def inner_relationship
      @inner_inner_relationship
    end

    def self.included(base)
      base.extend(Neology::RelationshipMixin::ClassMethods)
    end

  end

end