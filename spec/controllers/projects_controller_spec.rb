require 'spec_helper'

describe ProjectsController do
  
  describe "visiting projects as a sub account" do
    before :each do
      @company = Factory.create(:company)
      @user = Factory.create(:user, :company => @company, :owns_company => true)
      @sub_account = Factory.create(:user, :email => 'sub@example.com', :company => @company, :sub_account => true)
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