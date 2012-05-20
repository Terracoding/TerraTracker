#coding: utf-8
require 'spec_helper'

describe Subscription do
  context :validations do
    it { should belong_to(:company) }
  end

  context :unsubscribe do
    before :each do
      @company = FactoryGirl.create(:company)
      FactoryGirl.create(:user, :company => @company, :owns_company => true)
      FactoryGirl.create(:subscription, :company => @company)
      @company.plan = FactoryGirl.build(:plan)
      @company.subscription.unsubscribe
    end

    it "should reset the company plan after unsubscribing" do
      Company.find(@company.id).plan_id.should == 1
    end

    it "should set the subscription subscribed to false" do
      @company.subscription.subscribed.should == false
    end
  end
end
