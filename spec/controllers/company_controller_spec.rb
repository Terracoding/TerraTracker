require 'spec_helper'

describe CompanyController do

  describe "creating a company" do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    
    it "should create the company" do
      post :new
      response.should be_success
      sign_out @user
    end

    it "should create a new company" do
      company = mock_model(Company, :save => true)
      Company.stub(:new) { company }
      company.stub_chain(:plan, :user_count).and_return(5000)
      company.stub_chain(:users, :count).and_return(1)
      post :create, :company => {}
      response.should redirect_to(company_index_path)
      sign_out @user
    end
    
    it "should render new when not saving the company" do
      company = mock_model(Company, :save => false)
      Company.stub(:new) { company }
      post :create, :company => {}
      response.should render_template(:new)
      sign_out @user
    end
    
    it "should edit the company" do
      company = FactoryGirl.create(:company)
      post :edit, :id => company.id
      response.should be_success
      sign_out @user
    end
    
    it "should update the company" do
      company = mock_model(Company, :update_attributes => true)   
      Company.stub(:find).with("12") { company }
      post :update, :id => "12"
      response.should redirect_to(company_index_path)
      sign_out @user
    end
    
    it "should render edit if not updated attributes" do
      company = mock_model(Company, :update_attributes => false)   
      Company.stub(:find).with("12") { company }
      post :update, :id => "12"
      response.should render_template(:edit)
      sign_out @user
    end
  end
  
  describe "redirecting" do
    before :each do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      @sub_account = FactoryGirl.create(:user, :email => 'sub@example.com', :company => @company, :sub_account => true)
    end

    it "should redirect to the dashboard when visting as a sub account" do
      sign_in @sub_account
      post :index, :user => {}
      response.should redirect_to(dashboard_index_path)
      sign_out @sub_account
    end

    it "should not redirect to the dashboard when visting as company owner" do
      sign_in @user
      post :index, :user => {}
      response.should_not redirect_to(dashboard_index_path)
      sign_out @user
    end

  end

end
