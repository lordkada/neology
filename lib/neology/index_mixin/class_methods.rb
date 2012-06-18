module Neology

  module IndexMixin

    module ClassMethods

      def indexes_array
        @indexes_array ||= Array.new
      end

      def index index_name
        #p "#{self.name}: adding index_mixin = #{index_name}"
        indexes_array << index_name.to_s unless indexes_array.include? index_name.to_s
      end

      def delete_node_index(node)
        #p "removing index #{_index_name} for #{node["self"]}"
        $neo_server.remove_node_from_index(_index_name, node)
      end

      def update_node_index(node, property_name, old_value, new_value)
        #p "updating index #{_index_name} for #{node["self"]}: #{property_name} = #{old_value} --> #{new_value}"
        $neo_server.remove_node_from_index(_index_name, property_name, old_value, node)
        $neo_server.add_node_to_index(_index_name, property_name, new_value, node)
      end


      def add_node_index(node, property_name, value)
        #p "adding index #{_index_name} for #{node["self"]}: #{property_name} = #{value}"
        $neo_server.add_node_to_index(_index_name, property_name, value, node)
      end

      def find query
        #p "querying: #{self.name},#{_index_name}, #{query}"
        QueryBuilder.new self.name, _index_name, query
      end

      def _index_name
        "#{_class_name}_index"
      end

    end

  end

end