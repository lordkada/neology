require 'spec_helper'
require 'mocks/neology_user'
require 'mocks/neology_user_type'

describe "node specs" do

  describe "relationships creation" do

    it "should create a 'one' relationship between user and userType" do

      user     = NeologyUser.create
      userType = NeologyUserType.create

      user.type = userType
      user.type.id.should == userType.id

    end

    it "should create a 'n' relationship between userType and user" do

      user_a   = NeologyUser.create
      user_b   = NeologyUser.create
      userType = NeologyUserType.create

      userType.user<<user_a
      userType.user<<user_b

      userType.user.size.should == 2
      userType.user.should include( user_a, user_b )

    end

  end

end