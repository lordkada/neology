module Neology

  class Traverser

    def initialize rels_mixin_instance, rels_keys
      @rels_mixin_instance = rels_mixin_instance
      @rels_keys           = rels_keys
    end

    def each(&block)
      @rels_keys.each { |rel_key| yield @rels_mixin_instance.rel_value[rel_key] }
    end

    def size
      rels.size
    end

    def [] index
      rels[index]
    end

    def rels
      @rels ||=calc_rels
    end

    def calc_rels

      @rels_keys.inject([]) { |memo, key|

        rel = @rels_mixin_instance.rel(key)

        if (rel.respond_to?(:each))
          memo.concat rel
        else
          memo<<rel
        end

      }

    end

  end

end