require 'neology/graph_mixin/graph_mixin'
require 'neology/relationship_mixin/class_methods'

module Neology

  module RelationshipMixin

    include GraphMixin

    def self.included(base)

      base.extend(Neology::RelationshipMixin::ClassMethods)

    end

  end

end