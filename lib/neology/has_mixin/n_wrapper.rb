module Neology

  module HasMixin

    class NWrapper

      def initialize relationship_declaration
        @relationship_declaration = relationship_declaration
        @wrapper_array = []
      end

      def << wrapper
        @wrapper_array<< wrapper
      end

      def size
        @wrapper_array.size
      end

      def include? element
        @wrapper_array.include? element
      end

      def each &block
        @wrapper_array.each do |wrapper|
          block.call wrapper.destination_wrapper
        end
      end

    end

  end

end