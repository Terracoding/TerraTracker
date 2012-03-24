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
    
    # it "should render new when not saving the new task" do
    #   task = mock_model(Task, :save => false)
    #   Task.stub(:build).and_return(task)
    #   task.stub(:save).and_return(false)
    #   post :create, :task => {}
    #   response.should render_template(:new)
    #   sign_out @user
    # end
  end

end
