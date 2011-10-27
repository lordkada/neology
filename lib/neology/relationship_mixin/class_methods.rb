module Neology

  module RelationshipMixin

    module ClassMethods

      def new relationship_name, source_wrapper, destination_wrapper, *options

        graph_rel = Neology::NeoServer.create_relationship(relationship_name, source_wrapper.inner_node, destination_wrapper.inner_node)
        Neology::NeoServer.set_relationship_properties(graph_rel, { "_classname" => self.name })

        wrapper = self.old_new graph_rel, source_wrapper, destination_wrapper
        wrapper.init_on_create(relationship_name, source_wrapper, destination_wrapper, *options) if wrapper.respond_to? (:init_on_create)
        wrapper

      end

      def load graph_rel_id
        graph_rel = Neology::NeoServer.get_relationship(graph_rel_id)
        _load graph_rel
      end

      def _load graph_rel

        if  graph_rel["data"]["_classname"]
          wrapper_class = Neology.const_get(graph_rel["data"]["_classname"].split('::').last)
        else
          wrapper_class = Neology::Relationship
        end

        wrapper_class.old_new(graph_rel,
                              Neology::Node.load(graph_rel["start"].split('/').last.to_i),
                              Neology::Node.load(graph_rel["end"].split('/').last.to_i))
      end

      def is_indexed? property_name
        (self.respond_to?(:find) && self.indexes_array().include?(property_name))
      end

    end

  end

end