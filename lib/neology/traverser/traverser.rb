require 'neology/relationship'

module Neology

  class Traverser

    def initialize from_node, *rel_names
      @from_node = from_node
      @all       = rel_names
      @to_other  = nil
      @incoming  = []
      @outgoing  = []
      @return    = "relationships"
    end

    def to_other to_other
      @to_other = to_other
      self
    end

    def incoming rel_name
      @incoming << rel_name
      self
    end

    def outgoing rel_name
      @outgoing << rel_name
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

    private

    def rels
      @rels ||=calc_rels
    end

    def calc_rels

      options       = { }

      #relationships

      relationships = @all.inject ([]) do |memo, rel_name|
        memo << {
                "type"      => rel_name,
                "direction" => "all"
        }
      end

      relationships = @incoming.inject (relationships) do |memo, rel_name|
        memo << {
                "type"      => rel_name,
                "direction" => "in"
        }
      end

      relationships = @outgoing.inject (relationships) do |memo, rel_name|
        memo << {
                "type"      => rel_name,
                "direction" => "out"
        }
      end

      options["relationships"] = relationships if relationships

      #filters
      if @to_other

        options["return filter"] = {
                "body"     => "position.endNode().id == #{@to_other.id}",
                "language" => "javascript"

        }

      end

      Neology::NeoServer.traverse(@from_node, @return, options).collect do |item|

        if (item["data"]["_classname"])
          Neology.const_get(item["data"]["_classname"].split('::').last)._load item
        end

      end

    end

  end

end