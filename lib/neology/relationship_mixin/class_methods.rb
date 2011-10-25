module Neology

  module RelationshipMixin

    module ClassMethods

      def create relationship_name, source_wrapper, destination_wrapper

        rel = Neology::NeoServer.get.create_relationship(relationship_name, source_wrapper.inner_node, destination_wrapper.inner_node)
        self.new rel, source_wrapper, destination_wrapper

      end

      #def load inner_relationship
      #  self.new inner_relationship
      #end

    end

  end

end