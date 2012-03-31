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
  
  context :can_manage do
    before(:each) do
      @company = Factory.create(:company)
      @user = Factory.create(:user, :company => @company, :owns_company => true)
      @sub_user = Factory.create(:user, :company => @company, :sub_account => true, :email => "subaccount@example.com")
      @project = Factory.create(:project, :company => @company)
      sign_in @sub_user
    end
    it "should redirect a sub_account on new" do
      post :new
      response.should redirect_to(tasks_path)
    end
    it "should redirect a sub_account on edit" do
      @task = Factory.create(:task, :project_id => @project.id)
      post :edit, :id => @task.id
      response.should redirect_to(tasks_path)
    end
    it "should redirect a sub_account on create" do
      post :create
      response.should redirect_to(tasks_path)
    end
    it "should redirect a sub_account on update" do
      @task = Factory.create(:task, :project_id => @project.id)
      put :update, :id => @task.id, :task => { :project_id => @project.id }
      response.should redirect_to(tasks_path)
    end
  end

  context :redirect_projects do
    before(:each) do
      @user = Factory.create(:user, :email => 'company@example.com')
      @company = Factory.create(:company)
      @user = Factory.create(:user, :company => @company, :owns_company => true)
      sign_in @user
    end

    it "should redirect if the project count is less than 1" do
      @company.stub_chain(:projects, :count).and_return(0)
      get :index
      response.should redirect_to(new_project_path)
    end

    it "should show an error message if the project count is less than 1" do
      @company.stub_chain(:projects, :count).and_return(0)
      get :index
      flash[:error].should == "You need to set up a project before you can create a task."
    end

    it "shouldn't redirect if the company has a project" do
      @project = Factory.create(:project, :company => @company)
      get :index
      response.should be_successful
    end
  end

end
