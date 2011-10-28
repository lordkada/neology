require 'neology/property_mixin/class_methods'

module Neology

  module PropertyMixin

    def []= key, value
      old_value = self.inner_node["data"][key]
      if (value != old_value)
        inner_node["data"][key] = value
        $neo_server.set_node_properties(inner_node, self.inner_node["data"])
        self.class.update_node_index(self.inner_node, key, old_value, value) if self.class.is_indexed?(key)
      end
    end

    def [] key
      self.inner_node["data"] = $neo_server.get_node_properties(self.inner_node)
      self.inner_node["data"][key]
    end

  end

end