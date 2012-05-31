require 'spec_helper'

describe DeveloperController do
  before(:each) do
    @company = FactoryGirl.create(:company)
    @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
    sign_in @user
  end

  context :index do
    it "should load the developer page" do
      get :index
      response.should be_success
    end
  end

  context :new do
    it "should load the create application page" do
      get :new
      response.should be_success
    end
  end

end
