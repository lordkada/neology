require 'spec_helper'
require 'mocks/mocks'

describe "node specs" do

  describe "node properties" do

    it "should allow to assign a property through '[prop_name]='" do

      node = Neology::Node.new

      node["property"] = 99

      reloaded = Neology::Node.load node.id

      reloaded.inner_node["data"]["property"].should == 99

      node.del

    end

    it "should allow to read a property through '[prop_name]'" do

      node = Neology::Node.new

      node["property"] = 99

      reloaded = Neology::Node.load node.id

      reloaded["property"].should == 99

      node.del

    end

  end

  describe "relation properties" do

    it "should allow to assign a property through '[prop_name]='" do

      node   = Neology::Node.new
      node_2 = Neology::Node.new

      rel = Neology::Relationship.new :test, node, node_2

      rel["property"] = 99

      reloaded = Neology::Relationship.load rel.id

      reloaded.inner_relationship["data"]["property"].should == 99

      rel.del
      node.del
      node_2.del

    end

    it "should allow to read a property through '[prop_name]'" do

      node   = Neology::Node.new
      node_2 = Neology::Node.new

      rel = Neology::Relationship.new :test, node, node_2

      rel["property"] = 99

      reloaded = Neology::Relationship.load rel.id

      reloaded["property"].should == 99

      rel.del
      node.del
      node_2.del

    end

  end

end