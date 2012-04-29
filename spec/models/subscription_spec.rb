#coding: utf-8
require 'spec_helper'

describe Subscription do
  context :validations do
    it { should belong_to(:user) }
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
  
  context :projects_limit do
    before(:each) do
      @subscription = Subscription.new
    end
    
    it "should return the starter package projects limit" do
      @subscription.stub(:plan_id).and_return(1)
      @subscription.projects_limit.should == 2
    end
    
    it "should return the basic package projects limit" do
      @subscription.stub(:plan_id).and_return(2)
      @subscription.projects_limit.should == 10
    end
    
    it "should return the professional package projects limit" do
      @subscription.stub(:plan_id).and_return(3)
      @subscription.projects_limit.should == 30
    end
    
    it "should return the free package projects limit" do
      @subscription.stub(:plan_id).and_return(0)
      @subscription.projects_limit.should == 1
    end
  end
  
  
  context :users_limit do
    before(:each) do
      @subscription = Subscription.new
    end
    
    it "should return the starter package users limit" do
      @subscription.stub(:plan_id).and_return(1)
      @subscription.users_limit.should == 2
    end
    
    it "should return the basic package users limit" do
      @subscription.stub(:plan_id).and_return(2)
      @subscription.users_limit.should == 15
    end
    
    it "should return the professional package users limit" do
      @subscription.stub(:plan_id).and_return(3)
      @subscription.users_limit.should == 100
    end
    
    it "should return the free package users limit" do
      @subscription.stub(:plan_id).and_return(0)
      @subscription.users_limit.should == 1
    end
  end

end
