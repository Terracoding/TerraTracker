require 'spec_helper'

describe CompanyUsersController do
  
  describe "methods" do
    before(:each) do
      @company = Factory.create(:company)
      @user = Factory.create(:user, :company => @company, :owns_company => true)
      sign_in @user
    end
  
    it "should create the company user" do
      post :new
      response.should be_success
      sign_out @user
    end
    
    it "should show the company user" do
      get :show, :id => @user.id
      response.should be_success
      sign_out @user
    end
    
    it "should create the company user" do
      company_user = Factory.create(:user, :email => "subaccount@example.com", :company => @company, :sub_account => true)
      User.stub(:new) { company_user }
      post :create, :user => {}
      response.should redirect_to(company_index_path)
      sign_out @user
    end
    
    it "should render new when not creating the company user" do
      company = mock_model(Company, :save => false)
      Company.stub(:build).and_return(company)
      company.stub(:save).and_return(false)
      post :create, :user => {}
      response.should render_template("new")
      sign_out @user
    end
  end

  context :destroy do
    before(:each) do
      @company = Factory.create(:company)
      @user = Factory.create(:user, :company => @company, :owns_company => true)
      sign_in @user
    end

    it "should delete a eligible user" do
      company_user = Factory.create(:user, :email => "subaccount@example.com", :company => @company, :sub_account => true)
      delete :destroy, :id => company_user.id
      flash[:notice].should == "The user was successfully removed."
      response.should redirect_to(company_index_path)
    end
    
    it "should not delete a illegible user" do
      delete :destroy, :id => @user.id
      flash[:notice].should == "You cannot delete this user."
      response.should redirect_to(company_index_path)
    end
  end

end