require 'spec_helper'

describe CompanyController do

  describe "creating a company" do
    
    before :each do
      @user = Factory.create(:user)
      sign_in @user
    end

    it "should create a new company" do
      company = mock_model(Company, :save => true)
      Company.stub(:new) { company }
      post :create, :company => {}
      response.should redirect_to(company_index_path)
    end
    
    it "should render new when not saving the company" do
      company = mock_model(Company, :save => false)
      Company.stub(:new) { company }
      post :create, :company => {}
      response.should render_template("new")
      sign_out @user
    end
    
    it "should render edit if not updated attributes" do
      company = mock_model(Company, :update_attributes => false)   
      Company.stub(:find).with("12") { company }
      post :update, :id => "12"
      response.should render_template("edit")
      sign_out @user
    end
  end

end





