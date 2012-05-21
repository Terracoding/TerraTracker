require 'spec_helper'

describe WebhooksController do

  context :receive_payload do
    describe "invalid payloads" do
      it "should return a message for no payload" do
        post :receive_payload, :format => :json
        response.body.should == "No payload found"
      end

      it "should return a status code for no payload" do
        post :receive_payload, :format => :json
        response.status.should == 401
      end

      it "should return a message for an invalid payload" do
        post :receive_payload, :format => :json, :payload => {}
        response.body.should == "Invalid payload"
      end

      it "should return a status code for an invalid payload" do
        post :receive_payload, :format => :json, :payload => {}
        response.status.should == 401
      end
    end

    describe "valid payloads" do
      before(:each) do
        GoCardless.stub(:webhook_valid?).and_return(true)
      end

      it "should receive a valid payload" do
        post :receive_payload, :format => :json, :payload => { :action => {} }
        response.status.should == 200
      end

      it "should check if a status isn't cancelled" do
        post :receive_payload, :format => :json, :payload => { :action => {} }
        response.body.should == "Nothing to change"
      end

      it "should return if no subscriptions are to be cancelled" do
        post :receive_payload, :format => :json, :payload => { :action => "cancelled", :subscriptions => [{ :status => ""}]}
        response.body.should == "0 successfully cancelled"
      end

      it "should return if a subscription has been cancelled" do
        company = Company.new
        subscription = Subscription.new(:company_id => company.id)
        Subscription.stub(:find_by_resource_id).and_return(subscription)
        Company.stub(:find).and_return(company)
        post :receive_payload, :format => :json, :payload => { :action => "cancelled", :subscriptions => [{ :status => "cancelled"}]}
        response.body.should == "1 successfully cancelled"
      end
      
      it "should return the count of cancelled subscriptions" do
        company = FactoryGirl.create(:company)
        subscription = FactoryGirl.create(:subscription, :company_id => company.id)
        post :receive_payload, :format => :json, :payload => { :action => "cancelled", :subscriptions => [{ :id => 10, :status => "cancelled"}]}
        response.body.should == "1 successfully cancelled"
      end

      it "should delete a subscription" do
        company = FactoryGirl.create(:company)
        subscription = FactoryGirl.create(:subscription, :company_id => company.id)
        post :receive_payload, :format => :json, :payload => { :action => "cancelled", :subscriptions => [{ :id => 10, :status => "cancelled"}]}
        Subscription.all.count.should == 0
      end

      it "should archive projects over the limit" do
        company = FactoryGirl.create(:company)
        subscription = FactoryGirl.create(:subscription, :company_id => company.id)
        FactoryGirl.create(:project, :company => company)
        FactoryGirl.create(:project, :company => company)
        plan = FactoryGirl.create(:plan, :project_count => 1)
        Plan.stub(:find).and_return(plan)
        post :receive_payload, :format => :json, :payload => { :action => "cancelled", :subscriptions => [{ :id => 10, :status => "cancelled"}]}
        Project.where(:company_id => company.id, :archived => true).count.should == 1
      end

      it "should change the company plan to free" do
        plan = FactoryGirl.create(:plan, :title => "Expensive")
        company = FactoryGirl.create(:company, :plan_id => plan.id)
        subscription = FactoryGirl.create(:subscription, :company_id => company.id)
        post :receive_payload, :format => :json, :payload => { :action => "cancelled", :subscriptions => [{ :id => subscription.resource_id, :status => "cancelled"}]}
        Company.find(company.id).plan.id.should == 1
      end
    end
  end

end