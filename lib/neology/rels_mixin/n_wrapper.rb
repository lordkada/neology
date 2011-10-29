module Neology

  module RelsMixin

    class NWrapper

      def initialize source_node, relationship_declaration=nil, inner_rels_array=nil
        @source_node              = source_node
        @relationship_declaration = relationship_declaration
        @inner_rels_array         = inner_rels_array || []
      end

      def rel_name= rel_name
        @rel_name= rel_name
      end

      def << wrapper

        if wrapper.respond_to?(:each)
          wrapper.each { |wrapper_item|
            add_wrapper wrapper_item
          }
        else
          add_wrapper wrapper
        end

      end

      def size
        @inner_rels_array.size
      end

      def include? element
        @inner_rels_array.each do |element|
          return element["end"].split('/').last.to_i == element.id
        end
      end

      def each &block
        @inner_rels_array.each do |rel|
          block.call Neology::Node.load(rel["end"].split('/').last.to_i)
        end
      end

      def collect &block
        @inner_rels_array.collect do |rel|
          block.call Neology::Node.load(rel["end"].split('/').last.to_i)
        end
      end

      def to_a
        self.each.to_a
      end

      def to_ary
        self.to_a
      end

      private

      def add_wrapper wrapper

        if @relationship_declaration
          @relationship_declaration.validate! wrapper
          rel = $neo_server.create_relationship(@relationship_declaration.name, @source_node.inner_node, wrapper.inner_node)
        else
          rel = $neo_server.create_relationship(@rel_name, @source_node.inner_node, wrapper.inner_node)
        end

        @inner_rels_array<< rel

      end

    end

  end

end