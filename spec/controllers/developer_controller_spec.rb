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

  context :show do
    it "should successfully show a developer application" do
      application = FactoryGirl.create(:developer_application, :user => @user)
      get :show, :id => application.id
      response.should be_success
    end
  end

  context :create do
    it "should redirect when saving a new application" do
      application = FactoryGirl.create(:developer_application, :user => @user)
      DeveloperApplication.stub(:new) { application }
      post :create
      response.should redirect_to(developer_index_path)
      sign_out @user
    end

    it "should render new if there was an error saving the application" do
      
    end
  end

  context :edit do
    it "should be able to edit applications" do
      
    end
  end
end
