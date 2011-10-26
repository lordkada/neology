require 'neology/relationship'

module Neology

  module HasMixin

    module ClassMethods

      def has_one relationship_name
        rel_decl = RelationshipDeclaration.new relationship_name
        set_one_rel(relationship_name, rel_decl)
        define_relationship_one_setter relationship_name
        define_relationship_getter relationship_name
        rel_decl
      end

      def has_n relationship_name
        rel_decl = RelationshipDeclaration.new relationship_name
        set_n_rel(relationship_name, rel_decl)
        define_relationship_getter relationship_name
        rel_decl
      end

      def define_relationship_one_setter relationship_name
        send :define_method, "#{relationship_name}=".to_sym do |value|
          rel_decl = self.class.get_rel_decl relationship_name
          rel_decl.validate! value
          relationships_values_hash[relationship_name] = rel_decl.create(self, value)
        end
      end

      def define_relationship_getter relationship_name
        send :define_method, "#{relationship_name}".to_sym do
          value = self.relationship relationship_name
          return value.end_node if ( self.class.get_rel_type(relationship_name) == :one_relationship )
          value
        end
      end

    end

  end

end