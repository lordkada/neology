require 'neology/relationship'

module Neology

  class Traverser

    def initialize from_node, *rel_names
      @from_node = from_node
      @all       = rel_names || []
      @dir       = nil
      @to_other  = nil
      @incoming  = []
      @outgoing  = []
      @return    = "relationships"
      @depth     = 1
      @filter    = nil
    end

    def to_other to_other
      @to_other = to_other
      self
    end

    def incoming rel_name= nil
      @dir = :incoming
      @incoming << rel_name if rel_name
      self
    end

    def outgoing rel_name= nil
      @dir = :outgoing
      @outgoing << rel_name if rel_name
      self
    end

    def depth n
      @depth = n
      self
    end

    def filter code
      @filter = code
      self
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

    def << node
      create_rel node
      self
    end

    def first
      rels[0]
    end

    def create_rel node
      if @all.size > 0 || (@incoming.size + @outgoing.size > 1)
        raise "cannot create a new relationship, because multiple directions found!"
      end
      if @incoming.size > 0
        Neology::Relationship.new @incoming[0], node, @from_node
      else
        Neology::Relationship.new @outgoing[0], @from_node, node
      end
    end

    private

    def dir
      if @dir
        return (@dir == :incoming) ? "in" : "out"
      end
    end

    def rels
      @rels ||=calc_rels
    end

    def calc_rels

      options       = { "depth" => @depth }

      #relationships

      relationships = @all.inject ([]) do |memo, rel_name|
        memo << {
                "type"      => rel_name,
                "direction" => dir || "all"
        }
      end

      relationships = @incoming.inject (relationships) do |memo, rel_name|
        memo << {
                "type"      => rel_name,
                "direction" => dir || "in"
        }
      end

      relationships = @outgoing.inject (relationships) do |memo, rel_name|
        memo << {
                "type"      => rel_name,
                "direction" => dir || "out"
        }
      end

      options["relationships"] = relationships if relationships

      #filters
      if @to_other

        options["return filter"] = {
                "body"     => "position.endNode().id == #{@to_other.id}",
                "language" => "javascript"

        }

      elsif @filter

        options["return filter"] = {
                "body"     => "#{@filter}",
                "language" => "javascript"

        }

      end

      $neo_server.traverse(@from_node.inner_node, @return, options).collect do |item|

        if (item["data"]["_classname"])
          Neology.const_get(item["data"]["_classname"].split('::').last)._load item
        else
          Neology::Relationship._load item
        end

      end

    end

  end

end