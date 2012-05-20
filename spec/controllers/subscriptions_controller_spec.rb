require 'spec_helper'

class ApiError
  attr_accessor :status, :body
  def initialize(status, body)
    @status = status
    @body = body
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
      apiError = ApiError.new(401, "This is a random API error")
      GoCardless::Subscription.stub(:find) { raise GoCardless::ApiError.new(apiError) }
      @subscription = FactoryGirl.create(:subscription, :company => @company)
      Subscription.stub(:find_by_company_id).and_return(@subscription)
      get :index
      flash[:error].should == "GoCardless::ApiError [401] "
    end

    after :each do
      sign_out @user
    end
  end

  context :confirm_subscription do
    pending "not yet tested"
  end

end
