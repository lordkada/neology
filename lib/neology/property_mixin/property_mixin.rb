require 'neology/property_mixin/class_methods'
require 'neology/utils/data_type_converter'

module Neology

  module PropertyMixin

    def []= key, value
      old_value = self.inner_node["data"][key.to_s]
      if (value != old_value)
        inner_node["data"][key.to_s] = value
        $neo_server.set_node_properties(inner_node, self.inner_node["data"])
        self.class.update_node_index(self.inner_node, key.to_s, old_value, value) if self.class.is_indexed?(key)
      end
    end

    def [] key
      self.inner_node["data"] = $neo_server.get_node_properties(self.inner_node)
      value                   = self.inner_node["data"][key.to_s]
      options = self.class.properties_hash[key.to_sym]
      value = Neology::DataTypeConverter.convert_to_native value, options[:type] if (options && options[:type])
      value
    end

  end

end