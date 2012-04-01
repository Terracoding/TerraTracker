require 'spec_helper'

describe Subscription do
  context :validations do
    it { should belong_to(:user) }
  end

  context :available_plans do
    it "should return the available plans" do
      @subscription = Subscription.new
      @subscription.available_plans.should == [{ :id => 1, :name => "Starter $5.99/mo"}, { :id => 2, :name => "Basic $10.99/mo"}, { :id => 3, :name => "Professional $19.99/mo"}]
    end
  end

  context :to_s do
    before(:each) do
      @subscription = Subscription.new
    end

    it "should return the starter package" do
      @subscription.stub(:plan_id).and_return(1)
      @subscription.to_s.should == "Starter"
    end

    it "should return the basic package" do
      @subscription.stub(:plan_id).and_return(2)
      @subscription.to_s.should == "Basic"
    end

    it "should return the professional package" do
      @subscription.stub(:plan_id).and_return(3)
      @subscription.to_s.should == "Professional"
    end

    it "should return the free package" do
      @subscription.stub(:plan_id).and_return(nil)
      @subscription.to_s.should == "Free"
    end
  end

end
