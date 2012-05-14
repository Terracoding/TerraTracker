require 'spec_helper'

describe SubscriptionsHelper do

  context :current_plan do
    it "should true if the current company plan is the same" do
      user = FactoryGirl.create(:user)
      plan = Plan.new(:title => "title")
      @current_company = FactoryGirl.build(:company, :user => user)
      @current_company.stub(:plan).and_return(plan)
      current_plan(plan).should be_true
    end

    it "should false if the current company plan is not the same" do
      user = FactoryGirl.create(:user)
      plan = Plan.new(:title => "title")
      @current_company = FactoryGirl.build(:company, :user => user)
      current_plan(plan).should be_false
    end
  end

end
