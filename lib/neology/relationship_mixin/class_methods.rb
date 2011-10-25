module Neology

  module RelationshipMixin

    module ClassMethods

      def create relationship_name, source_wrapper, destination_wrapper
        self.new Neology::NeoServer.get.create_relationship( relationship_name, source_wrapper.inner_node, destination_wrapper.inner_node)
      end

      def load inner_relationship
        self.new inner_relationship
      end

    end

  end

end