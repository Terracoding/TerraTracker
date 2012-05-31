require 'spec_helper'

describe DeveloperController do
  before(:each) do
    @company = FactoryGirl.create(:company)
    @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
    sign_in @user
  end

  after(:each) do
    sign_out @user
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
    end

    it "should show a success message when saving a new application" do
      application = FactoryGirl.create(:developer_application, :user => @user)
      DeveloperApplication.stub(:new) { application }
      post :create
      flash[:notice].should == "The application was successfully created."
    end

    it "should render new if there was an error saving the application" do
      application = FactoryGirl.create(:developer_application, :user => @user)
      DeveloperApplication.stub(:new) { application }
      application.stub(:save).and_return(false)
      post :create
      response.should render_template(:new)
    end
  end

  context :update do
    before(:each) do
      @application = FactoryGirl.create(:developer_application, :user => @user)
    end

    it "should redirect to developer applications path after updating" do
      put :update, :id => @application.id
      flash[:notice].should == "The application was successfully updated."
      response.should redirect_to(developer_index_path)
    end

    it "should render edit template if not updated attributes" do
      DeveloperApplication.should_receive(:find).and_return(@application)
      @application.stub(:update_attributes).and_return(false)
      put :update, :id => @application.id
      response.should render_template(:edit)
    end
  end
end
