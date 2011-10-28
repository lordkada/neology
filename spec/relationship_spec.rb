require 'spec_helper'
require 'mocks/mocks'

describe "node specs" do

  describe "dealing with Relationship" do

    it "should load a relationship by id"

    it "should create the attributes for the relationship" do

      source_node = Neology::Node.new
      dest_node = Neology::Node.new

      rel = NeologyRAuthoredComment.new :test_rel, source_node, dest_node, 52

      reloaded = Neology::Relationship.load rel.id
      reloaded.score.should == 52

      source_node.del
      dest_node.del

    end

    it "should instance the relationship wrapper"

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

    it "should return relations of 'neology_r_author' kind" do

      comment = NeologyComment.new
      user    = NeologyUser.new

      comment.author= user
      rels          = comment.rels(:author)

      rels.size.should == 1
      rels[0].kind_of?(NeologyRAuthor).should be_true

      comment.del
      user.del

    end

    it "should return only all the relations" do

      comment = NeologyComment.new
      user    = NeologyUser.new
      voter_1 = NeologyUser.new
      voter_2 = NeologyUser.new
      voter_3 = NeologyUser.new
      voter_4 = NeologyUser.new

      comment.author= user
      comment.voters<<[voter_1, voter_2, voter_3, voter_4]

      voters = comment.rels
      voters.size.should == 5

      comment.del
      user.del
      voter_1.del
      voter_2.del
      voter_3.del
      voter_4.del

    end

    it "should return only voters relations" do

      comment = NeologyComment.new
      user    = NeologyUser.new
      voter_1 = NeologyUser.new
      voter_2 = NeologyUser.new
      voter_3 = NeologyUser.new
      voter_4 = NeologyUser.new

      comment.author= user
      comment.voters<<[voter_1, voter_2, voter_3, voter_4]

      voters = comment.rels(:voters)
      voters.size.should == 4

      voters.collect { |rel|
        rel.end_node.id
      }.should =~ [voter_1.id, voter_2.id, voter_3.id, voter_4.id]

      comment.del
      user.del
      voter_1.del
      voter_2.del
      voter_3.del
      voter_4.del

    end

    it "user should have only one incoming relationship -> user.rel (:incoming, :comment)" do
      comment = NeologyComment.new
      user    = NeologyUser.new

      comment.author= user
      comment.voters<< user

      rel = user.rel(:incoming, :author)

      rel.start_node.id.should == comment.id
      rel.end_node.id.should == user.id

      comment.del
      user.del
    end

    it "should be only one relationship between comment and voter 3" do

      comment = NeologyComment.new
      user    = NeologyUser.new
      voter_1 = NeologyUser.new
      voter_2 = NeologyUser.new
      voter_3 = NeologyUser.new
      voter_4 = NeologyUser.new

      comment.author= user
      comment.voters<<[voter_1, voter_2, voter_3, voter_4]

      rels = comment.rels(:voters).to_other(voter_3)

      rels.size.should == 1
      rels[0].start_node.id.should == comment.id
      rels[0].end_node.id.should == voter_3.id

      comment.del
      user.del
      voter_1.del
      voter_2.del
      voter_3.del
      voter_4.del

    end

    it "should return all outgoing relationships" do

      comment = NeologyComment.new
      user    = NeologyUser.new
      voter_1 = NeologyUser.new
      voter_2 = NeologyUser.new
      voter_3 = NeologyUser.new
      voter_4 = NeologyUser.new

      comment.author= user
      comment.voters<<[voter_1, voter_2, voter_3, voter_4]

      rels = comment.rels.outgoing(:voters)

      rels.size.should == 4

      comment.del
      user.del
      voter_1.del
      voter_2.del
      voter_3.del
      voter_4.del

    end

    it "should return all incoming relationships" do

      comment = NeologyComment.new
      user    = NeologyUser.new
      voter_1 = NeologyUser.new
      voter_2 = NeologyUser.new
      voter_3 = NeologyUser.new
      voter_4 = NeologyUser.new

      comment.author= user
      comment.voters<<[user, voter_1, voter_2, voter_3, voter_4]

      rels = user.rels.incoming(:author)

      rels.size.should == 1

      comment.del
      user.del
      voter_1.del
      voter_2.del
      voter_3.del
      voter_4.del


    end

    it "should create an indexed relationship" do

      comment = NeologyComment.new
      user    = NeologyUser.new

      comment.author= user
      user.authored_comment << comment

      user.authored_comment.size.should == 1

      comment.del
      user.del

    end
  end

end