module Neology

  module RelsMixin

    module ClassMethods

      def get_rel_decl(name)
        relationships_hash[name][:relationship_declaration] if relationships_hash[name]
      end

      def get_rel_type(name)
        relationships_hash[name][:type] if relationships_hash[name]
      end

      def get_rel_names
        @relationships_hash.keys
      end
      private

      def relationships_hash
        @relationships_hash ||= { }
      end

      def set_one_rel(name, decl)
        relationships_hash[name] = { :relationship_declaration => decl, :type => :one_relationship }
      end

      def set_n_rel(name, decl)
        relationships_hash[name] = { :relationship_declaration => decl, :type => :n_relationship }
      end

    end

  end

end