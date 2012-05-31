require 'spec_helper'

describe SupportController do

  context :index do
    it "should load the support page" do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      sign_in @user
      response.should be_success
    end
  end

  context :create do
    it "should be able to send an email" do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      sign_in @user
      post :create, :support_message => { :name => "john doe", :body => "Hello, world", :email => "test@example.com" }
      mail = ActionMailer::Base.deliveries.last
      mail.from.should == ["test@example.com"]
      mail.body.should include("Hello, world")
    end
  end

end
