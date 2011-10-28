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

    def rel direction, rel_name
      rel = (direction==:outgoing) ? relationships_values_hash[rel_name] : $neo_server.get_node_relationships(self.inner_node, 'in', rel_name)
      raise RuntimeError ("relationship #{rel_name} is a n_type and cannot be accessed through 'rel' method") if rel.respond_to?(:each) && rel.size > 1
      Neology::Relationship._load(rel[0]) if rel
    end

    def rels(*rel_name)
      Traverser.new(self.inner_node, *rel_name)
    end

    def incoming rel_name
      Traverser.new(self.inner_node).incoming(rel_name)
    end

    def outgoing rel_name
      Traverser.new(self.inner_node).outgoing(rel_name)
    end

    private

    def relationships_values_hash
      @relationships_values_hash||={ }
    end

  end

end