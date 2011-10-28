require 'spec_helper'
require 'mocks/mocks'

describe "traverser specs" do
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

  it "shoud return all incoming relationships using 'user.incoming(rel)' syntax" do

    comment = NeologyComment.new
    user    = NeologyUser.new
    voter_1 = NeologyUser.new
    voter_2 = NeologyUser.new
    voter_3 = NeologyUser.new
    voter_4 = NeologyUser.new

    comment.author= user
    comment.voters<<[user, voter_1, voter_2, voter_3, voter_4]

    rels = user.incoming(:author)

    rels.size.should == 1

    comment.del
    user.del
    voter_1.del
    voter_2.del
    voter_3.del
    voter_4.del

  end

  it "should return all outgoing relationships using 'user.outgoing(rel)' syntax" do

    comment = NeologyComment.new
    user    = NeologyUser.new
    voter_1 = NeologyUser.new
    voter_2 = NeologyUser.new
    voter_3 = NeologyUser.new
    voter_4 = NeologyUser.new

    comment.author= user
    comment.voters<<[voter_1, voter_2, voter_3, voter_4]

    rels = comment.outgoing(:voters)

    rels.size.should == 4

    comment.del
    user.del
    voter_1.del
    voter_2.del
    voter_3.del
    voter_4.del

  end

  it "shoud return all incoming relationships using 'user.incoming(rel)' syntax" do

    comment = NeologyComment.new
    voter_1 = NeologyUser.new

    comment.incoming(:voters) << voter_1

    rels = comment.incoming(:voters)

    rels.size.should == 1

    comment.del
    voter_1.del

  end

  it "shoud return all incoming relationships using 'user.rels(rel).incoming' syntax" do

    comment = NeologyComment.new
    voter_1 = NeologyUser.new

    comment.incoming(:voters) << voter_1

    rels = comment.rels(:voters).incoming

    rels.size.should == 1

    comment.del
    voter_1.del

  end

end