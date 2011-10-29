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

    it "should the node properties be converted to native values" do

      user = NeologyUserAllProperties.new

      user[:float_type]   = Math::PI
      user[:integer_type] = Math::PI
      user[:string_type]  = Math::PI

      reloaded = Neology::Node.load user.id

      reloaded[:float_type].should == Math::PI.to_f

      reloaded[:integer_type].should == Math::PI.to_i

      reloaded[:string_type].should == Math::PI.to_s

      user.del

    end

    it "should the relationship properties be converted to native values" do

      user   = Neology::Node.new
      user_2 = Neology::Node.new
      rel    = NeologyRelationshipAllProperties.new :test, user, user_2

      rel[:float_type]   = Math::PI
      rel[:integer_type] = Math::PI
      rel[:string_type]  = Math::PI

      reloaded = Neology::Relationship.load rel.id

      reloaded[:float_type].should == Math::PI.to_f

      reloaded[:integer_type].should == Math::PI.to_i

      reloaded[:string_type].should == Math::PI.to_s

      user.del
      user_2.del
      rel.del

    end


  end

end