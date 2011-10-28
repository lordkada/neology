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
          self.set_relationship relationship_name, value
        end
      end

      def define_relationship_getter relationship_name
        send :define_method, "#{relationship_name}".to_sym do
          self.relationship relationship_name
        end
      end

    end

  end

end