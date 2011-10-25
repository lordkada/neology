module Neology

  module HasMixin

    module ClassMethods

      def relationships_hash
        @relationships_hash ||= { }
      end

      def has_one relationship_name
        rel_decl                              = RelationshipDeclaration.new relationship_name
        relationships_hash[relationship_name] = { :relationship_declaration => rel_decl, :type => :one_relationship, :wrapper => nil }

        define_relationship_one_setter relationship_name
        define_relationship_one_getter relationship_name

        rel_decl
      end

      def define_relationship_one_setter relationship_name

        send :define_method, "#{relationship_name}=".to_sym do |value|

          #controllare se la relazione: 1- era già valorizzata 2- è cambiata
          p "define_relationship_one_setter #{relationship_name}"

          rel_decl = self.class.relationships_hash[relationship_name][:relationship_declaration]

          if rel_decl.is_acceptable_to? value

            wrapper_class = (rel_decl.relationship) ? rel_decl.to_sym : Neology::Relationship

            p self
            #(self.class.relationships_hash[relationship_name])[:wrapper] = wrapper_class.create(relationship_name, self, value)

          else
            raise "node #{value} is not acceptable for relationship #{relationship_name}"
          end

        end

      end

      def define_relationship_one_getter relationship_name

        send :define_method, "#{relationship_name}".to_sym do

          p "define_relationship_one_getter #{relationship_name}"
          self.class.relationships_hash[relationship_name][:wrapper]

        end

      end

    end

  end

end