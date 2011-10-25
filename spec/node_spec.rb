require 'spec_helper'
require 'mocks/neology_user'

describe "node specs" do

  describe "nodes creation" do

    it "should create a new graph user object with 7.3 as initial score" do

      graphUser = NeologyUser.create({ :score => 7.3 })
      graphUser.should be_true
      graphUser.score.should == 7.3

    end

    it "should create a new graph user object with 0 as initial score" do

      graphUser = NeologyUser.create
      graphUser.should be_true
      graphUser.score.should == 0

    end

    it "should create a new graph user object with 0 as initial score, then updated to 3" do

      graphUser = NeologyUser.create
      graphUser.should be_true
      graphUser.score.should == 0.0
      graphUser.score = 3
      graphUser.score.should == 3

    end

  end

end