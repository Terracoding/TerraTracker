require 'spec_helper'

describe TimeslipsController do
  
  context :index do
    before(:each) do
      @company = Factory.create(:company)
      @user = Factory.create(:user, :company => @company, :owns_company => true)
      @sub_user = Factory.create(:user, :company => @company, :sub_account => true, :email => "subaccount@example.com")
      @project = Factory.create(:project, :company => @company)
      @sub_timeslip = Factory.create(:timeslip, :project => @project, :user => @sub_user)
      @user_timeslip = Factory.create(:timeslip, :project => @project, :user => @user)
    end

    describe "company owner" do
      it "should show the current timeslips for the company" do
        sign_in @user
        get :index
        assigns[:timeslips].count.should == 2
        sign_out @user
      end
    end

    describe "company sub account" do
      it "should show the current timeslips for the user" do
        sign_in @sub_user
        get :index
        assigns[:timeslips].count.should == 1
        sign_out @sub_user
      end
    end
  end
  
  context :new do
    before(:each) do
      @company = Factory.create(:company)
      @user = Factory.create(:user, :company => @company, :owns_company => true)
      @sub_user = Factory.create(:user, :company => @company, :sub_account => true, :email => "subaccount@example.com")
      @project = Factory.create(:project, :company => @company)
      @sub_timeslip = Factory.create(:timeslip, :project => @project, :user => @sub_user)
      @user_timeslip = Factory.create(:timeslip, :project => @project, :user => @user)
    end
    
    describe "project manager" do
      before(:each) do
        sign_in @user
        post :new
      end
      
      after(:each) do
        sign_out @user
      end

      it "should create a new task" do
        response.should be_success
      end
    
      it "should get the current tasks" do
        task = Factory.create(:task, :project_id => @project.id, :name => 'task name')
        assigns[:tasks].count.should == 1
      end
    
      it "should get the current projects" do
        assigns[:projects].count.should == 1
      end
    
      it "should get the current users" do
        assigns[:users].count.should == 2
      end
    end
    
    describe "project sub account" do
      before(:each) do
        sign_in @sub_user
        post :new
      end
      
      after(:each) do
        sign_out @sub_user
      end

      it "should create a new task" do
        response.should be_success
      end
    
      it "should get the current tasks" do
        task = Factory.create(:task, :project_id => @project.id, :name => 'task name')
        assigns[:tasks].count.should == 1
      end
    
      it "should get the current projects" do
        assigns[:projects].count.should == 1
      end
    
      it "should get the current users" do
        assigns[:users].count.should == 1
      end
    end
  end

end
