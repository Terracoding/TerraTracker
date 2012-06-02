require 'spec_helper'

describe Api::V1::UsersController do
  describe :login do
    context :without_api_key do
      it "returns a 401 error" do
        DeveloperApplication.stub!(:exists?).and_return(false)
        post :login, :format => :json
        response.status.should == 401
      end
    end

    context :with_api_key do
      it "returns a 200 success" do
        DeveloperApplication.stub!(:exists?).and_return(true)
        post :login,
          :format => :json,
          :authorization => "Token token=\"arbitrary_value\""
        response.status.should == 200
      end
    end
  end
end
