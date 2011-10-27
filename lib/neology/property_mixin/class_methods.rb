module Neology

  module PropertyMixin

    module ClassMethods

      def _class_name
        self.name
      end

      def properties_hash
        @properties_hash ||= { }
      end

      def property property_name, options= nil
        self.properties_hash[property_name] = options if options
        define_property_setter property_name.to_s
        define_property_getter property_name.to_s
      end

      def define_property_setter property_name
        send :define_method, "#{property_name}=".to_sym do |value|
          old_value = self.inner_node["data"][property_name]
          if (value != old_value)
            self.inner_node["data"][property_name] = value
            Neology::NeoServer.set_node_properties(inner_node, self.inner_node["data"])
            self.class.update_node_index(self.inner_node, property_name, old_value, value) if self.class.is_indexed?(property_name)
          end
        end
      end

      def define_property_getter property_name
        send :define_method, property_name.to_sym do
          self.inner_node["data"] = Neology::NeoServer.get_node_properties(self.inner_node)
          self.inner_node["data"][property_name.to_s]
        end
      end

    end

  end

end