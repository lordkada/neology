module Neology

  class Traverser

    def initialize relationship_values_hash, rel_names
      @relationship_values_hash = relationship_values_hash
      @rel_names                = rel_names
    end

    def each &block
      rels.each { |rel|
        yield rel
      }
    end

    def collect &block
      rels.collect { |rel|
        yield rel
      }
    end

    def size
      rels.size
    end

    def [] index
      rels[index]
    end

    private

    def rels
      @rels ||=calc_rels
    end

    def calc_rels

      keys = (@rel_names.size == 0) ? @relationship_values_hash.keys : @rel_names

      keys.inject([]) { |memo, key|

        rel = @relationship_values_hash[key]

        if (rel.respond_to?(:each))
          memo.concat rel
        else
          memo<<rel
        end

      }

    end

  end

end