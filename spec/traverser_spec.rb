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

  it "should return the first voter" do

    comment = NeologyComment.new
    voter_1 = NeologyUser.new
    voter_2 = NeologyUser.new
    voter_3 = NeologyUser.new
    voter_4 = NeologyUser.new

    comment.voters<<[voter_1, voter_2, voter_3, voter_4]

    rel = comment.outgoing(:voters).first

    rel.start_node.should == comment
    rel.end_node.should == voter_1

  end

  it "should return the nodes with depth 1" do

    node   = Neology::Node.new
    node_2 = Neology::Node.new
    node_3 = Neology::Node.new

    rel_1 = Neology::Relationship.new :rel, node, node_2
    rel_2 = Neology::Relationship.new :rel, node_2, node_3

    rels = node.rels.outgoing
    rels.size.should == 1
    rels.first.start_node.should == node
    rels.first.end_node.should == node_2

    rel_1.del
    rel_2.del
    node.del
    node.del
    node.del

  end

  it "should return the nodes with depth 2" do

    node   = Neology::Node.new
    node_2 = Neology::Node.new
    node_3 = Neology::Node.new

    rel_1 = Neology::Relationship.new :rel, node, node_2
    rel_2 = Neology::Relationship.new :rel, node_2, node_3

    rels = node.rels.outgoing.depth(2)

    rels.size.should == 2
    rels[0].start_node.should == node
    rels[0].end_node.should == node_2
    rels[1].start_node.should == node_2
    rels[1].end_node.should == node_3


    rel_1.del
    rel_2.del
    node.del
    node_2.del
    node_3.del

  end

  it "should return the nodes with :ok relation" do

    node   = Neology::Node.new
    node_2 = Neology::Node.new
    node_3 = Neology::Node.new
    node_4 = Neology::Node.new
    node_5 = Neology::Node.new

    rel_1 = Neology::Relationship.new :ok, node, node_2
    rel_2 = Neology::Relationship.new :no, node, node_3
    rel_3 = Neology::Relationship.new :ok, node_2, node_4
    rel_4 = Neology::Relationship.new :ok, node_2, node_5

    rels = node.rels.outgoing.filter("(position.lastRelationship() !=null) && (position.lastRelationship().getType().name().compareTo('ok')==0);").depth(2)

    rels.size.should == 3

    rels.collect { |rel|
      rel.id
    }.should =~ [rel_1.id, rel_3.id, rel_4.id]

    rel_1.del
    rel_2.del
    rel_3.del
    rel_4.del
    node.del
    node_2.del
    node_3.del
    node_4.del
    node_5.del

  end

end