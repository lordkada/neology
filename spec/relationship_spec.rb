require 'spec_helper'
require 'mocks/mocks'

describe "node specs" do

  describe "dealing with Relationship" do

    it "should load a relationship by id" do

      source_node = Neology::Node.new
      dest_node   = Neology::Node.new

      rel = Neology::Relationship.new :test_rel, source_node, dest_node

      reloaded = Neology::Relationship.load rel.id

      reloaded.should be_true

      source_node.del
      dest_node.del

    end

    it "should create the attributes for the relationship" do

      source_node = Neology::Node.new
      dest_node   = Neology::Node.new

      rel = NeologyRAuthoredComment.new :test_rel, source_node, dest_node, 52

      reloaded = Neology::Relationship.load rel.id
      reloaded.score.should == 52

      source_node.del
      dest_node.del

    end

  end

  describe "relationships creation" do

    it "should create a 'one' relationship between user and userType" do

      user     = NeologyUser.new
      userType = NeologyUserType.new

      user.type = userType
      user.type.id.should == userType.id

      user.del
      userType.del

    end

    it "should create a 'n' relationship between userType and user" do

      user_a   = NeologyUser.new
      user_b   = NeologyUser.new
      userType = NeologyUserType.new

      userType.user<<user_a
      userType.user<<user_b

      userType.user.size.should == 2
      userType.user.collect do |rel|
        rel.end_node
      end.should include(user_a, user_b)

      user_a.del
      user_b.del
      userType.del

    end

    it "shouldn't be able to assign a comment to userType.user relationship" do

      comment  = NeologyComment.new
      userType = NeologyUserType.new

      lambda { userType.user << comment }.should raise_exception

      comment.del
      userType.del

    end

  end

end