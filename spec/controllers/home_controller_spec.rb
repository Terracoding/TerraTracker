require 'spec_helper'

describe HomeController do
  context :home do
    it "should load the home page" do
      get :index
      response.should be_success
    end
  end
  context :plans do
    before :each do
      get :plans
    end
    it "should load the plans page" do
      response.should be_success
    end
    it "should get the available plans" do
      assigns[:plans].count.should > 0
    end
  end
end