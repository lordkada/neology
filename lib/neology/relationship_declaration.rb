module Neology

  class RelationshipDeclaration

    attr_reader :name

    def initialize relationship_name
      @name = relationship_name
    end

    def validate! wrapper_node
      return true if get_to.nil? || wrapper_node.kind_of?(get_to)
      raise RuntimeError.new("node #{value} is not acceptable for relationship #{relationship_name}")
    end

    def to to_wrapper
      @to_wrapper = to_wrapper
      self
    end

    def relationship relationship
      @relationship = relationship
      self
    end

    def get_to
      @to_wrapper
    end

    def create source_node, destination_node
      (@relationship ? @relationship : Neology::Relationship).create(@name, source_node, destination_node)
    end

  end

end