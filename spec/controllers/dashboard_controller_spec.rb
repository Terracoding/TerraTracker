require 'spec_helper'

describe DashboardController do
  
  context :index do
    before(:each) do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      @project = FactoryGirl.create(:project, :company => @company)
      @task = FactoryGirl.create(:task, :project_id => @project.id)
      sign_in @user
      get :index
    end
    it "should show the current company" do
      assigns(:current_company).should == @company
    end
    it "should get the companies projects" do
      assigns(:projects).count.should == 1
    end
  end

end
