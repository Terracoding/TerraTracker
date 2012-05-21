require 'spec_helper'

class ApiError
  attr_accessor :status
  def initialize()
    @status = 401
  end
end

describe SubscriptionsController do

  context :index do
    before :each do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      sign_in @user
    end

    it "should load successfully" do
      get :index
      response.should be_success
    end

    it "should return an error with an invalid subscription" do
      @subscription = FactoryGirl.create(:subscription, :company => @company)
      Subscription.stub(:find_by_company_id).and_return(@subscription)
      get :index
      flash[:error].should == "There was a problem with your subscription. Please contact support for further information."
    end

    it "should return other errors when there is an GoCardless API error" do
      apiError = ApiError.new
      GoCardless::Subscription.stub(:find) { raise GoCardless::ApiError.new(apiError) }
      @subscription = FactoryGirl.create(:subscription, :company => @company)
      Subscription.stub(:find_by_company_id).and_return(@subscription)
      get :index
      flash[:error].should_not be_empty
    end

    after :each do
      sign_out @user
    end
  end

  context :confirm_subscription do
    before :each do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      sign_in @user
    end

    it "should show a message when confirming a bad resource" do
      apiError = ApiError.new
      GoCardless.stub(:confirm_resource).and_return(nil)
      GoCardless.stub(:confirm_resource).and_raise(GoCardless::ApiError.new(apiError))
      post :confirm_subscription
      flash[:error].should_not be_empty
    end

    it "should" do
      
    end
  end

end
