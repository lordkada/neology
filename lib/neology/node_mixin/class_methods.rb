require 'active_support/inflector'

module Neology

  module NodeMixin

    module ClassMethods

      def create(*args)
        attributes = { "ts" => Time.now.to_f, "_classname" => _class_name }
        attributes = attributes.merge(self.create_custom) if self.respond_to? :create_custom

        attributes.merge! args[0] if args.size == 1

        base_root = find_root!(self.name.downcase.pluralize)

        node = Neology::NeoServer.get.create_node(attributes)
        Neology::NeoServer.get.create_relationship("base", base_root, node)

        self.create_bulk_indexes node, attributes if respond_to?(:find)

        self.new(node)
      end

      def load node
        self.new node
      end

      def is_indexed? property_name
        (self.respond_to?(:find) && self.indexes_array().include?(property_name))
      end

      private

      def find_root! root_name

        rootNode = RestUtils.find_node :name, root_name

        return rootNode if rootNode

        rootNode = Neology::NeoServer.get.create_node({ "name" => root_name, "score" => 0.0 })

        Neology::NeoServer.get.create_relationship("base", Neology::NeoServer.get.get_root, rootNode)

        rootNode

      end

    end

  end

end