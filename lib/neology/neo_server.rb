module Neology

  class NeoServer

    def initialize neo_server
      @neo_server = neo_server
    end

    #Nodes
    def get_root
      @neo_server.get_root
    end

    def create_node *args
      @neo_server.create_node *args
    end

    def delete_node *args
      @neo_server.delete_node *args
    end

    def delete_node! *args
      @neo_server.delete_node! *args
    end

    def get_node id
      @neo_server.get_node id
    end

    def set_node_properties id, properties
      @neo_server.set_node_properties id, properties
    end

    def get_node_properties *args
      @neo_server.get_node_properties *args
    end

    #Relationships
    def get_relationship id
      @neo_server.get_relationship id
    end

    def create_relationship type, from, to, props = nil
      @neo_server.create_relationship type, from, to, props
    end

    def set_relationship_properties id, properties
      @neo_server.set_relationship_properties id, properties
    end

    def get_relationship_properties rel
      @neo_server.get_relationship_properties rel
    end

    def get_node_relationships *args
      @neo_server.get_node_relationships *args
    end

    def delete_relationship *args
      @neo_server.delete_relationship *args
    end

    #indexes
    def add_node_to_index index, key, value, id
      @neo_server.add_node_to_index index, key, value, id
    end

    def remove_node_from_index *args
      @neo_server.remove_node_from_index *args
    end

    def add_relationship_to_index index, key, value, id
      @neo_server.add_relationship_to_index index, key, value, id
    end

    def delete_relationship_from_index *args
      @neo_server.remove_relationship_from_index *args
    end

    def execute_script *args
      @neo_server.execute_script *args
    end

    def traverse id, return_type, description
      @neo_server.traverse id, return_type, description
    end

  end

end