module Neology

  module RelationshipIndexMixin

    module ClassMethods

      def relationship_indexes_array
        @relationship_indexes_array ||= Array.new
      end

      def index index_name
        #p "#{self.name}: adding relationship index_mixin = #{index_name}"
        relationship_indexes_array << index_name.to_s unless relationship_indexes_array.include? index_name.to_s
      end

      def delete_relationship_index(relationship)
        p "removing relationship index #{_index_name} for #{node["self"]}"
        $neo_server.remove_relationship_from_index(_index_name, relationship)
      end

      def update_relationship_index(relationship, property_name, old_value, new_value)
        #p "updating relationship index #{_index_name} for #{relationship["self"]}: #{property_name} = #{old_value} --> #{new_value}"
        $neo_server.delete_relationship_from_index(_index_name, property_name, old_value, relationship)
        $neo_server.add_relationship_to_index(_index_name, property_name, new_value, relationship)
      end


      def add_relationship_index(relationship, property_name, value)
        #p "adding relationship index #{_index_name} for #{node["self"]}: #{property_name} = #{value}"
        $neo_server.add_relationship_to_index(_index_name, property_name, value, relationship)
      end

      def find query
        #p "relationship querying: #{self.name},#{_index_name}, #{query}"
        QueryBuilder.new self.name, _index_name, query
      end

      def _index_name
        "#{_class_name}_index"
      end

    end

  end

end