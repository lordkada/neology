require 'spec_helper'
require 'mocks/mocks'

describe "Index specs" do

  describe "node indexes" do

    before(:all) do

      graphUser = NeologyUser.new 7.3
      graphUser = NeologyUser.new 0
      graphUser = NeologyUser.new 3

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

    it "should change the order because updated attribute" do

      sorted_users               = NeologyUser.find("score: *").desc("score")
      sorted_users.to_a[0].score = 1.5

      sorted_users = NeologyUser.find("score: *").desc("score")
      sorted_users.size.should == 3
      memo = sorted_users.inject([]) do |memo, user|
        memo << user.score
      end
      memo.should == [3, 1.5, 0]

    end

    after(:all) do

      NeologyUser.find("score: *").each do |user|
        user.del
      end

    end

  end

  describe "relationship indexes" do

    it "should find all the NeologyRAuthoredComment in desc order by score" do

      comment   = NeologyComment.new
      comment_2 = NeologyComment.new
      comment_3 = NeologyComment.new

      user   = NeologyUser.new
      user_2 = NeologyUser.new
      user_3 = NeologyUser.new

      rel1= NeologyRAuthoredComment.new :authored_comment, user, comment, 3
      rel2= NeologyRAuthoredComment.new :authored_comment, user_2, comment_2, 7
      rel3= NeologyRAuthoredComment.new :authored_comment, user_3, comment_3, 1

      res = NeologyRAuthoredComment.find('score: *').desc(:score)

      res.collect do |rel|
        rel.score
      end.should =~ [7, 3, 1]

      rel1.del
      rel2.del
      rel3.del

      comment.del
      comment_2.del
      comment_3.del

      user.del
      user_2.del
      user_3.del

    end
  end

end