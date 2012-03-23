require 'spec_helper'

describe ProjectsController do
  
  describe "visiting projects as a sub account" do
    before :each do
      @company = Factory.create(:company)
      @user = Factory.create(:user, :company => @company, :owns_company => true)
      @sub_account = Factory.create(:user, :email => 'sub@example.com', :company => @company, :sub_account => true)
    end

    it "should redirect to the dashboard when visting as a sub account" do
      sign_in @sub_account
      post :index, :user => {}
      response.should redirect_to(dashboard_index_path)
      sign_out @sub_account
    end
    
    it "should not redirect to the dashboard when visting as company owner" do
      sign_in @user
      post :index, :user => {}
      response.should_not redirect_to(dashboard_index_path)
      sign_out @user
    end
  end
  
  context :create do
    before(:each) do
      @company = Factory.create(:company)
      @user = Factory.create(:user, :company => @company, :owns_company => true)
      sign_in @user
    end
    
    it "should create a new project with a company" do
      project = Factory.build(:project, :company => @company)
      project.company.should == @company
      sign_out @user
    end
    
    it "should render new when not saving the new project" do
      project = mock_model(Project, :save => false)
      Project.stub(:build).and_return(project)
      project.stub(:save).and_return(false)
      post :create, :project => {}
      response.should render_template("new")
      sign_out @user
    end
  end
  
  context :edit do
    before(:each) do
      @company = Factory.create(:company)
      @user = Factory.create(:user, :company => @company, :owns_company => true)
      @project = Factory.create(:project, :company => @company)
      sign_in @user
    end
    
    it "should be able to be updated" do
      post :update, :id => @project.id
      flash[:notice].should == "The project was successfully updated."
      response.should redirect_to(projects_path)
      sign_out @user
    end
    
    it "should render edit if not updated attributes" do
      project = mock_model(Project, :update_attributes => false)   
      Project.stub(:find).with("12") { project }
      post :update, :id => "12"
      response.should render_template("edit")
      sign_out @user
    end
  end
  
end