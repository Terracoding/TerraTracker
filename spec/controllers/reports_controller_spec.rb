require 'spec_helper'

describe ReportsController do
  context :index do
    before(:each) do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      @sub_user = FactoryGirl.create(:user, :company => @company, :sub_account => true, :email => "subaccount@example.com")
      @project = FactoryGirl.create(:project, :company => @company)
    end

    it "should show the current projects for the company" do
      sign_in @user
      get :index
      assigns[:projects].count.should == 1
      sign_out @user
    end

    it "should get the tasks for the company" do
      @task = FactoryGirl.create(:task, :project_id => @project.id)
      sign_in @user
      get :index
      assigns[:tasks].count.should == 1
      sign_out @user
    end

    it "should get the available timeframes" do
      sign_in @user
      get :index
      assigns[:timeframes].should == [["This Week", 1], ["Last Week", 2], ["This Month", 3], ["Last Month", 4]]
      sign_out @user
    end

    it "should create a new report" do
      sign_in @user
      get :index
      assigns[:report].should == Report.new
      sign_out @user
    end

    describe "company owner" do
      it "should get the company users" do
        sign_in @user
        get :index
        assigns[:users].count.should == 2
        sign_out @user
      end
    end

    describe "sub account" do
      it "should get the company users" do
        sign_in @sub_user
        get :index
        assigns[:users].count.should == 1
        sign_out @sub_user
      end
    end
  end

  context :generating_reports do
    before(:each) do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      @sub_user = FactoryGirl.create(:user, :company => @company, :sub_account => true, :email => "subaccount@example.com")
      @project = FactoryGirl.create(:project, :company => @company)
      @task = FactoryGirl.create(:task, :project_id => @project.id)
      sign_in @user
    end

    it "should generate a report" do
      post :generate_report, :report => { :user_id => @user.id, :task_id => @task.id, :project_id => @project.id }
      response.should be_successful
    end

    it "should generate a pdf" do
      post :view_report, :report => { :user_id => @user.id, :task_id => @task.id, :project_id => @project.id }
      response.should be_successful
    end

    it "should return to index if the report is invalid" do
      report_stub = stub
      report_stub.stub(:valid?).and_return(false)
      Report.stub(:new).with(nil).and_return(report_stub)
      controller.stub!(:get_report_data).with(report_stub).and_return(report_stub)
      controller.stub!(:get_timeslips)
      post :view_report
      response.should be_successful
    end
  end
end