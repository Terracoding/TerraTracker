require 'spec_helper'

describe SubscriptionsController do
  class MockApiError
    attr_accessor :status
    def initialize
      @status = 401
    end
  end

  class MockConfirmation
    attr_accessor :merchant_id, :amount, :user_id
    def initialize
      @amount = 100
    end
  end

  class MockSubscription
    def initialize
    end
    def cancel!
      true
    end
  end

  context :index do
    before :each do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true, :sub_account => false, :company_admin => true)
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
      apiError = MockApiError.new
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
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true, :sub_account => false, :company_admin => true)
      @plan = FactoryGirl.create(:plan, :title => "New Plan", :value => 100)
      @confirmation = MockConfirmation.new
      sign_in @user
    end

    it "should show a message when confirming a bad resource" do
      apiError = MockApiError.new
      GoCardless.stub(:confirm_resource).and_return(nil)
      GoCardless.stub(:confirm_resource).and_raise(GoCardless::ApiError.new(apiError))
      post :confirm_subscription
      flash[:error].should_not be_empty
    end

    it "should show a message when changing to a new plan" do
      GoCardless.stub(:confirm_resource).and_return(@confirmation)
      post :confirm_subscription
      flash[:notice].should == "You have successfully subscribed to the #{@plan.title.capitalize} plan."
    end

    it "should update the companies plan" do
      GoCardless.stub(:confirm_resource).and_return(@confirmation)
      post :confirm_subscription
      Company.find_by_id(@company.id).plan.value.should == @confirmation.amount
    end

    it "should mean the company only has one set subscription" do
      GoCardless.stub(:confirm_resource).and_return(@confirmation)
      post :confirm_subscription
      Subscription.where(:company_id => @company.id).count.should == 1
    end
  end

  context :cancel do
    before :each do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true, :sub_account => false, :company_admin => true)
      @subscription = FactoryGirl.create(:subscription, :company => @company)
      sign_in @user
    end

    it "should return an error with an invalid subscription" do
      Subscription.stub(:find_by_company_id).and_return(@subscription)
      GoCardless::Subscription.stub(:find).and_return(GoCardless::Subscription.new)
      GoCardless::Subscription.stub(:cancel!).and_return(true)
      post :cancel
      flash[:error].should_not be_empty
    end

    it "should cancel a subscription" do
      Subscription.stub(:find_by_company_id).and_return(@subscription)
      GoCardless::Subscription.stub(:find).and_return(MockSubscription.new)
      post :cancel
      Subscription.where(:company_id => @company.id).count.should == 0
    end

    it "should show a success message" do
      Subscription.stub(:find_by_company_id).and_return(@subscription)
      GoCardless::Subscription.stub(:find).and_return(MockSubscription.new)
      post :cancel
      flash[:notice].should == "You have cancelled your subscription!"
    end

    it "should archive projects over the new limit" do
      FactoryGirl.create(:project, :company => @company)
      FactoryGirl.create(:project, :company => @company)
      plan = FactoryGirl.create(:plan, :project_count => 1)
      Plan.stub(:find).and_return(plan)
      Subscription.stub(:find_by_company_id).and_return(@subscription)
      GoCardless::Subscription.stub(:find).and_return(MockSubscription.new)
      post :cancel
      Project.where(:company_id => @company.id, :archived => false).count.should == 1
    end
  end

end
