module Neology

  module RestUtils

    def self.get_id node

      node["self"].split('/').last.to_i

    end

    def self.clear_db start_node


      Neology::NeoServer.traverse(start_node, "nodes", { "order"         => "depth first",
                                                             "uniqueness"    => "node global",
                                                             "relationships" => [{ "type"      => "base", # A hash containg a description of the traversal
                                                                                   "direction" => "out" }],
                                                             "return filter" => { "language" => "builtin",
                                                                                  "name"     => "all_but_start_node" },
                                                             "depth"         => 1 }).each do |node|

         p "ci passo #{node}"
        clear_db node
      end

      node_rels = Neology::NeoServer.get_node_relationships(start_node)

      if node_rels

        node_rels.each do |rel|

          Neology::NeoServer.delete_relationship rel

        end

      end

      unless start_node.nil? || (start_node && /node\/0/.match(start_node["self"]))
        Neology::NeoServer.delete_node start_node
        #p "deleting node #{start_node["self"]}"
        p "deleting index #{start_node["data"]["_classname"]+"_index"}"
        Neology::NeoServer.remove_node_from_index(start_node["data"]["_classname"]+"_index", start_node)
      end

      def self.find_node property, value, start_node_id = 0, max_depth= 1

        start_node = Neology::NeoServer.get_node start_node_id

        if start_node

          filter = "position.endNode().hasProperty('#{property}') && position.endNode().getProperty('#{property}') == '#{value}';"

          traverser = Neology::NeoServer.traverse(start_node, "nodes", {
                  "order"         => "breadth first",
                  "uniqueness"    => "node_global",
                  "depth"         => max_depth,
                  "return filter" => { "language" => "javascript",
                                       "body"     => filter }
          })

          return traverser.first unless traverser.empty?

        end

      end

    end

    def self.exists_relationship_between? first_node, type, second_node

      second_node_id = OA::Graph::RestUtils.get_id second_node

      Neology::NeoServer.traverse(first_node, "nodes", {
              "order"         => "depth first",
              "uniqueness"    => "node_mixin global",
              "relationships" => [{ "type"      => type,
                                    "direction" => "all" }],
              "return filter" => { "language" => "javascript",
                                   "body"     => "position.endNode().getId() == #{second_node_id};" },
              "depth"         => 1
      }).size > 0

    end

    def self.follow_and_return_node node, relationship

      out_rel = follow_and_return_nodes(node, relationship, limit=1)

      out_rel.first if out_rel && out_rel.size > 0

    end

    def self.follow_and_return_nodes node, relationship, limit=0

      out_rel = Neology::NeoServer.get_node_relationships(node, "out", relationship)

      index = 0

      if out_rel

        out_rel.find_all do

          loop = true

          if limit > 0

            if index >= limit

              loop = false

            end

            index += 1

          end

          loop

        end.collect do |rel|

          Neology::NeoServer.get_node rel["end"]

        end

      else

        []

      end

    end

  end

end