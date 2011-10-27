require 'active_support/inflector'

module Neology

  module NodeMixin

    module ClassMethods

      def new(*args)

        graph_node = Neology::NeoServer.create_node({ "_classname" => self.name })
        wrapper    = self.old_new graph_node

        wrapper.init_on_create(*args) if wrapper.respond_to? (:init_on_create)

        #self.create_bulk_indexes(graph_node, attributes) if respond_to?(:find)
        wrapper

      end

      def load graph_node_id
        graph_node = Neology::NeoServer.get_node(graph_node_id)

        if  graph_node["data"]["_classname"]
          wrapper_class = Object.const_get(graph_node["data"]["_classname"])
        else
          wrapper_class = Node
        end

        wrapper_class.old_new(graph_node)
      end

      def is_indexed? property_name
        (self.respond_to?(:find) && self.indexes_array().include?(property_name))
      end

    end

  end

end