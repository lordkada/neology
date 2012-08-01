require 'active_support/inflector'

module Neology

  module NodeMixin

    module ClassMethods

      def new(*args)
        if (args.size == 1 and args[0].instance_of? Node)
          wrapper    = self.old_new args[0]
        else
          graph_node = $neo_server.create_node({ "_classname" => self.name })
          wrapper    = self.old_new graph_node
        end

        wrapper.init_on_create(*args) if wrapper.respond_to? (:init_on_create)

        #self.create_bulk_indexes(graph_node, attributes) if respond_to?(:find)
        wrapper

      end

      def load graph_node_id
        graph_node = $neo_server.get_node(graph_node_id)
        _load graph_node
      end

      def _load graph_node
        if  graph_node["data"]["_classname"]
          wrapper_class = Neology.const_get(graph_node["data"]["_classname"].split('::').last)
        else
          wrapper_class = Node
        end

        wrapper_class.old_new(graph_node)
      end

      def is_indexed? property_name
        (self.respond_to?(:find) && self.indexes_array().include?(property_name.to_s))
      end

    end

  end

end