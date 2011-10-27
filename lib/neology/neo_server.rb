require 'neography'

module Neology

  module NeoServer

    #Nodes
    def self.get_root
      neo_server.get_root
    end

    def self.create_node *args
      neo_server.create_node *args
    end

    def self.delete_node *args
      neo_server.delete_node *args
    end

    def self.delete_node! *args
      neo_server.delete_node! *args
    end

    def self.get_node id
      neo_server.get_node id
    end

    def self.set_node_properties id, properties
      neo_server.set_node_properties id, properties
    end

    def self.get_node_properties *args
      neo_server.get_node_properties *args
    end

    #Relationships
    def self.get_relationship id
      neo_server.get_relationship id
    end

    def self.create_relationship type, from, to, props = nil
      neo_server.create_relationship type, from, to, props
    end

    def self.set_relationship_properties id, properties
      neo_server.set_relationship_properties id, properties
    end

    def self.get_node_relationships *args
      neo_server.get_node_relationships *args
    end

    def self.delete_relationship *args
      neo_server.delete_relationship *args
    end

    #indexes
    def self.add_node_to_index index, key, value, id
      neo_server.add_node_to_index index, key, value, id
    end

    def self.delete_node_index *args
      neo_server.delete_node_index *args
    end

    def self.remove_node_from_index *args
      neo_server.remove_node_from_index *args
    end

    def self.execute_script *args
      neo_server.execute_script *args
    end

    def self.traverse id, return_type, description
      neo_server.traverse id, return_type, description
    end

    private

    def self.neo_server
      $neo_server ||= Neography::Rest.new(:server => 'localhost', :log_enabled => true, :log_file => "../neography.log")
    end

  end

end