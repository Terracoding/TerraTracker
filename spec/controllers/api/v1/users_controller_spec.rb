require 'spec_helper'

describe Api::V1::UsersController do
  context :login do
    it "should return unauthorised if the key has not been validated" do
      post :login, :format => :json
      response.body.should include("Unauthorised")
      response.status.should == 401
    end

    it "should login a user" do
      post :login, :format => :json
      response.body.should include("hello")
      response.status.should == 200
    end
  end
end