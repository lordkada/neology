require 'spec_helper'
require 'mocks/neology_user'
require 'mocks/neology_user_type'

describe "node specs" do

  describe "relationships creation" do

    it "should create a 'one' relationship between user and userType" do

      user     = NeologyUser.create
      userType = NeologyUserType.create({ :user_type => "author" })

      user.type = userType

      user.type.id.should == userType.id

    end

  end

end