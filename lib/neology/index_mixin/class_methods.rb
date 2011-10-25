module Neology

  module IndexMixin

    module ClassMethods

      def indexes_array
        @indexes_array ||= Array.new
      end

      def create_bulk_indexes(node, attributes)
        #p "create_bulk_indexes"
        Neology::NeoServer.get.remove_node_from_index(_index_name, node)
        indexes_array.each do |index|
           add_node_index(node, index, attributes[index])
        end
      end

      def index index_name
        #p "#{self.name}: adding index_mixin = #{index_name}"
        indexes_array << index_name unless indexes_array.include? index_name
      end

      def remove_node_index(node, property_name, value)
        #p "removing index #{_index_name} for #{node["self"]}: #{property_name} = #{value}"
        Neology::NeoServer.get.remove_node_from_index(_index_name, property_name, value, node)
      end

      def add_node_index(node, property_name, value)
        #p "adding index #{_index_name} for #{node["self"]}: #{property_name} = #{value}"
        Neology::NeoServer.get.add_node_to_index(_index_name, property_name, value, node)
      end

      def find query
        #p "querying: #{self.name},#{_index_name}, #{query}"
        QueryBuilder.new self.name, _index_name, query
      end

      private

      def _index_name
        "#{_class_name}_index"
      end

    end

  end

end