require 'spec_helper'

require 'mocks/neology_user'

describe "Index specs" do

  before(:all) do

    graphUser = NeologyUser.create({ :score => 7.3 })
    graphUser = NeologyUser.create
    graphUser = NeologyUser.create
    graphUser.score = 3

  end

  it "should find the users by descending score order" do

    sorted_users = NeologyUser.find("score: *").desc("score")
    sorted_users.size.should == 3
    memo = sorted_users.inject([]) do |memo, user|
      memo << user.score
    end
    memo.should == [7.3, 3, 0]

  end

  it "should find the users by ascending score order" do

    sorted_users = NeologyUser.find("score: *").asc("score")
    sorted_users.size.should == 3
    memo = sorted_users.inject([]) do |memo, user|
      memo << user.score
    end
    memo.should == [0, 3, 7.3]

  end


end