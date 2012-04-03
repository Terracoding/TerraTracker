require 'spec_helper'

describe AccountsController do

  context :index do
    it "should require an authenticated user" do
      get :index
      response.should redirect_to(new_user_session_path)
    end

    it "should get the current company" do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      sign_in @user
      get :index
      response.should be_successful
    end
  end

end
