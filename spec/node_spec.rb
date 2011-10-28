require 'spec_helper'
require 'mocks/mocks'

describe "node specs" do

  describe "Node interaction" do

    it "should load a node by id" do
      root = Neology::Node.load 0
      root.should be_true
    end

    it "should instance the node wrapper" do
      user = NeologyUser.new 48
      id   = user.id

      reloaded = Neology::Node.load id
      reloaded.score.should == user.score

      user.del
    end

  end

  describe "nodes creation" do

    it "should create a new graph user object with 7.3 as initial score" do

      graphUser = NeologyUser.new 7.3
      graphUser.should be_true
      graphUser.score.should == 7.3

      graphUser.del
    end

    it "should create a new graph user object with 0 as initial score" do

      graphUser = NeologyUser.new 0
      graphUser.should be_true
      graphUser.score.should == 0

      graphUser.del

    end

    it "should create a new graph user object with 0 as initial score, then updated to 3" do

      graphUser = NeologyUser.new 0
      graphUser.should be_true
      graphUser.score.should == 0.0
      graphUser.score = 3
      graphUser.score.should == 3

      graphUser.del

    end

  end

end