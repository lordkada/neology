require 'neology/relationship'
require 'neology/has_mixin/n_wrapper'

module Neology

  module HasMixin

    module ClassMethods

      def relationships_hash
        @relationships_hash ||= { }
      end

      def has_one relationship_name
        rel_decl                              = RelationshipDeclaration.new relationship_name
        relationships_hash[relationship_name] = { :relationship_declaration => rel_decl, :type => :one_relationship }
        define_relationship_one_setter relationship_name
        define_relationship_getter relationship_name
        rel_decl
      end

      def has_n relationship_name
        rel_decl                              = RelationshipDeclaration.new relationship_name
        relationships_hash[relationship_name] = { :relationship_declaration => rel_decl, :type => :n_relationship }
        define_relationship_getter relationship_name
        rel_decl
      end

      def define_relationship_one_setter relationship_name

        send :define_method, "#{relationship_name}=".to_sym do |destination_wrapper|
          rel_decl = self.class.relationships_hash[relationship_name][:relationship_declaration]
          if rel_decl.is_acceptable_to? destination_wrapper
            wrapper_class = (rel_decl.relationship) ? rel_decl.to_sym : Neology::Relationship

            self.relationships_values_hash[relationship_name] = wrapper_class.create(relationship_name, self, destination_wrapper)
          else
            raise "node #{value} is not acceptable for relationship #{relationship_name}"
          end
        end
      end

      def define_relationship_getter relationship_name
        #p "define_relationship_one_getter #{relationship_name}"
        send :define_method, "#{relationship_name}".to_sym do

          hash = self.class.relationships_hash[relationship_name]

          rel_decl = hash[:relationship_declaration]

          if (hash[:type] == :n_relationship && self.relationships_values_hash[relationship_name].nil?)
            self.relationships_values_hash[relationship_name] = Neology::HasMixin::NWrapper.new(rel_decl)
          end

          value = self.relationships_values_hash[relationship_name]
          value.respond_to?(:each) ? value : value.destination_wrapper

        end

      end

    end

  end

end