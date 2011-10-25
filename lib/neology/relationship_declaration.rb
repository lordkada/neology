module Neology

  class RelationshipDeclaration

    attr_reader :name
    attr_accessor :to
    attr_accessor :relationship

    def initialize relationship_name
      @name = relationship_name
    end

    def is_acceptable_to? wrapper_node
      return false if to && !wrapper_node.kind_of?(wrapper_node)
      true;
    end

  end

end