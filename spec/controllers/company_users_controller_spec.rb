require 'spec_helper'

describe CompanyUsersController do

  describe "creating a company user" do
    
    before :each do
      @company = Factory.create(:company)
      @company.save
      @user = Factory.create(:user)
      @user.company = @company
      @user.owns_company = true
      @user.save
      sign_in @user
    end

    it "should create a new company user" do
      company_user = Factory.create(:user, :email => "subaccount@example.com")
      company_user.company = @company
      company_user.sub_account = true
      User.stub(:new) { company_user }
      post :create, :user => {}
      response.should redirect_to(company_index_path)
      sign_out @user
    end
    
    it "should render new when not saving the company user" do
      company = mock_model(Company, :save => false)
      Company.stub(:build).and_return(company)
      company.stub(:save).and_return(false)
      post :create, :user => {}
      response.should render_template("new")
      sign_out @user
    end
    
  end
  
end