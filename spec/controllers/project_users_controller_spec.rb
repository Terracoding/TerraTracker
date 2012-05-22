require 'spec_helper'

describe ProjectUsersController do
  
  context :new do
    before :each do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      @sub_account = FactoryGirl.create(:user, :email => 'sub@example.com', :company => @company, :sub_account => true)
      @project = FactoryGirl.create(:project, :company => @company)
      sign_in @user
    end
    
    it "should create the project user" do
      post :new, :project_id => @project.id
      response.should be_success
      sign_out @user
    end
  end
  
  context :create do
    before :each do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      @sub_account = FactoryGirl.create(:user, :email => 'sub@example.com', :company => @company, :sub_account => true)
      @project = FactoryGirl.create(:project, :company => @company)
      sign_in @user
    end
    
    it "should redirect the user after create" do
      project_user = FactoryGirl.create(:project_user, :user => @user, :project => @project)
      ProjectUser.stub(:new) { project_user }
      post :create, :project_user => {}, :project_id => @project.id
      response.should redirect_to(project_path(@project))
      sign_out @user
    end
    
    it "should render new if create didn't save" do
      project_user = FactoryGirl.create(:project_user, :user => @user, :project => @project)
      ProjectUser.stub(:new) { project_user }
      project_user.stub(:save).and_return(false)
      post :create, :project_user => {}, :project_id => @project.id
      response.should render_template(:new)
      sign_out @user
    end
  end
  
  context :destroy do
    before :each do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      @sub_account = FactoryGirl.create(:user, :email => 'sub@example.com', :company => @company, :sub_account => true, :company_admin => false, :owns_company => false)
      @project = FactoryGirl.create(:project, :company => @company)
      sign_in @user
    end
    
    it "should redirect to the project" do
      @project_user = FactoryGirl.create(:project_user, :user => @user, :project => @project)
      delete :destroy, :id => @project_user.id, :project_id => @project.id
      response.should redirect_to(project_path(@project))
    end
    
    it "should show the successful notice" do
      @project_user = FactoryGirl.create(:project_user, :user => @sub_account, :project => @project)
      delete :destroy, :id => @project_user.id, :project_id => @project.id
      flash[:notice].should == "The user was successfully removed."
    end
    
    it "should remove the user" do
      @project_user = FactoryGirl.create(:project_user, :user => @sub_account, :project => @project)
      delete :destroy, :id => @project_user.id, :project_id => @project.id
      ProjectUser.exists?(@project_user.id).should be_false
    end
    
    it "should not allow the project manager to be removed" do
      @project_user = FactoryGirl.create(:project_user, :user => @user, :project => @project)
      delete :destroy, :id => @project_user.id, :project_id => @project.id
      ProjectUser.exists?(@project_user.id).should be_true
    end
    
    it "should show an error notice when the project manager is attempted to be removed" do
      @project_user = FactoryGirl.create(:project_user, :user => @user, :project => @project)
      delete :destroy, :id => @project_user.id, :project_id => @project.id
      ProjectUser.exists?(@project_user.id).should be_true
      flash[:error].should == "You cannot remove a project manager from the project users."
    end
  end
  
end
