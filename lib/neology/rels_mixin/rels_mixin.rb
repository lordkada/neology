require 'neology/traverser/traverser'
require 'neology/rels_mixin/class_methods'
require 'neology/rels_mixin/n_wrapper'

module Neology

  module RelsMixin

    def rel rel_name
      rel_decl = self.class.get_rel_decl rel_name
      if (self.class.get_rel_type(rel_name) == :n_relationship && relationships_values_hash[rel_name].nil?)
        relationships_values_hash[rel_name] = NWrapper.new(rel_decl)
      end

      relationships_values_hash[rel_name]
    end

    def rel_value rel_name
      rel = self.rel rel_name
      (rel.respond_to?(:each) ? rel : rel.end_node) if rel
    end

    def set_rel_value rel_name, value
      rel_decl = self.class.get_rel_decl rel_name
      rel_decl.validate! value
      rel_wrapper_class                   = (rel_decl.get_relationship) ? rel_decl.get_relationship : Neology::Relationship
      relationships_values_hash[rel_name] = rel_wrapper_class.create(rel_name, self, value)
    end

    def rels(*rel_name)
      Traverser.new(self, self.class.get_rel_names.find_all { |name| true unless (rel_name.size > 0 && !rel_name.include?(name)) })
    end

    private

    def relationships_values_hash
      @relationships_values_hash||={ }
    end

  end

end