require 'spec_helper'

describe TasksController do
  
  context :create do
    before(:each) do
      @company = Factory.create(:company)
      @user = Factory.create(:user, :company => @company, :owns_company => true)
      @project = Factory.create(:project, :company => @company)
      sign_in @user
    end
    
    it "should create a new task with a project" do
      task = Factory.build(:task, :project => @project)
      task.project.should == @project
      sign_out @user
    end
    
    it "should render new when not saving the new task" do
      post :create, :task => { :project_id => @project.id }
      response.should render_template(:new)
      sign_out @user
    end
  end

end
