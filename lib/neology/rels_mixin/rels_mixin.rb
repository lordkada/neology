require 'neology/traverser/traverser'
require 'neology/rels_mixin/class_methods'
require 'neology/rels_mixin/n_wrapper'

module Neology

  module RelsMixin

    def relationship rel_name

      rel_decl = self.class.get_rel_decl rel_name
      value = $neo_server.get_node_relationships(self.inner_node, "all", rel_name)

      if (self.class.get_rel_type(rel_name) == :n_relationship )
        value = NWrapper.new(self, rel_decl, value)
      end

      return Neology::Relationship._load(value[0]).end_node if ( self.class.get_rel_type(rel_name) == :one_relationship )
      value
    end

    def set_relationship rel_name, value
      rel_decl = self.class.get_rel_decl rel_name
      rel_decl.validate! value
      rel_decl.create(self, value)
    end

    def rel direction, rel_name
      rel = (direction==:outgoing) ? relationship(rel_name) : $neo_server.get_node_relationships(self.inner_node, 'in', rel_name)
      raise RuntimeError ("relationship #{rel_name} is a n_type and cannot be accessed through 'rel' method") if rel.respond_to?(:each) && rel.size > 1
      Neology::Relationship._load(rel[0]) if rel
    end

    def rels(*rel_name)
      Traverser.new(self, *rel_name)
    end

    def incoming rel_name
      Traverser.new(self).incoming(rel_name)
    end

    def outgoing rel_name
      Traverser.new(self).outgoing(rel_name)
    end

  end

end