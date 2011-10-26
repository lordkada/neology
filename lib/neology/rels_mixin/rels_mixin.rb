require 'neology/traverser/traverser'
require 'neology/rels_mixin/class_methods'
require 'neology/rels_mixin/n_wrapper'

module Neology

  module RelsMixin

    def relationship rel_name
      rel_decl = self.class.get_rel_decl rel_name
      if (self.class.get_rel_type(rel_name) == :n_relationship && relationships_values_hash[rel_name].nil?)
        relationships_values_hash[rel_name] = NWrapper.new(self, rel_decl)
      end
      relationships_values_hash[rel_name]
    end

    def rel rel_name
      rel = relationships_values_hash[rel_name]
      raise RuntimeError ("relationship #{rel_name} is a n_type and cannot be accessed through 'rel' method") if rel.respond_to?(:each)
      rel
    end

    def rels(*rel_name)
      Traverser.new(relationships_values_hash, rel_name)
    end

    private

    def relationships_values_hash
      @relationships_values_hash||={ }
    end

  end

end