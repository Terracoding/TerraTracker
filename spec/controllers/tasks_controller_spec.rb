require 'spec_helper'

describe TasksController do
  
  context :index do
    before(:each) do
      @company = Factory.create(:company)
      @user = Factory.create(:user, :company => @company, :owns_company => true)
      @project = Factory.create(:project, :company => @company)
      sign_in @user
    end
    
    it "should load the tasks" do
      post :index
      response.should be_success
      sign_out @user
    end
  end
  
  context :new do
    before(:each) do
      @company = Factory.create(:company)
      @user = Factory.create(:user, :company => @company, :owns_company => true)
      @project = Factory.create(:project, :company => @company)
      sign_in @user
    end
    
    it "should create a new task" do
      post :new
      response.should be_success
      sign_out @user
    end
  end
  
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
    
    it "should redirect when saving the new task" do
      task = Factory.create(:task, :project_id => @project.id, :name => 'task name')
      Task.stub(:new) { task }
      post :create, :task => { :project_id => @project.id }
      response.should redirect_to(tasks_path)
      sign_out @user
    end
    
    it "should render new when not saving the new task" do
      post :create, :task => { :project_id => @project.id }
      response.should render_template(:new)
      sign_out @user
    end
  end
  
  context :edit do
    before(:each) do
      @company = Factory.create(:company)
      @user = Factory.create(:user, :company => @company, :owns_company => true)
      @project = Factory.create(:project, :company => @company)
      @task = Factory.create(:task, :project_id => @project.id)
      sign_in @user
    end
    
    it "should edit the project" do
      post :edit, :id => @task.id
      response.should be_success
      sign_out @user
    end
  end
  
  context :update do
    before(:each) do
      @company = Factory.create(:company)
      @user = Factory.create(:user, :company => @company, :owns_company => true)
      @project = Factory.create(:project, :company => @company)
      @task = Factory.create(:task, :project_id => @project.id)
      sign_in @user
    end

    it "should redirect to tasks path after updating" do
      put :update, :id => @task.id, :task => { :project_id => @project.id }
      flash[:notice].should == "The task was successfully updated."
      response.should redirect_to(tasks_path)
      sign_out @user
    end
    
    it "should render edit template if not updated attributes" do
      Task.should_receive(:find).and_return(@task)
      @task.stub(:update_attributes).and_return(false)
      put :update, :id => @task.id, :task => { :project_id => @project.id }
      response.should render_template(:edit)
      sign_out @user
    end
  end
  
  context :destroy do
    before(:each) do
      @company = Factory.create(:company)
      @user = Factory.create(:user, :company => @company, :owns_company => true)
      @project = Factory.create(:project, :company => @company)
      @task = Factory.create(:task, :project_id => @project.id)
      sign_in @user
      delete :destroy, :id => @task.id
    end
  
    it "should redirect to the tasks path" do
      response.should redirect_to(tasks_path)
      sign_out @user
    end
    
    it "should show a flash notice" do
      flash[:notice].should == "The task was successfully removed."
      sign_out @user
    end
  end

end
