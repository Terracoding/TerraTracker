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
        request.env['HTTP_AUTHORIZATION'] = "Token token=\"arbitrary_value\""
        post :login, :format => :json
        response.status.should == 200
      end
    end
  end
end
