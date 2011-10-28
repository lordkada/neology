require 'neology/relationship_property_mixin/class_methods'

module Neology

  module RelationshipPropertyMixin

    def []= key, value
      old_value = self.inner_relationship["data"][key]
      if (value != old_value)
        self.inner_relationship["data"][key] = value
        $neo_server.set_relationship_properties(inner_relationship, self.inner_relationship["data"])
        self.class.update_relationship_index(self.inner_relationship, key, old_value, value) if self.class.is_indexed?(key)
      end
    end

    def [] key
      self.inner_relationship["data"] = $neo_server.get_relationship_properties(self.inner_relationship)
      self.inner_relationship["data"][key]
    end

  end

end