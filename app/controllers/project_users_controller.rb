class ProjectUsersController < ApplicationController
  before_filter :authenticate_user!, :redirect_company, :redirect_sub_account, :redirect_projects

  def new
    @project = Project.find(params[:project_id])
    @project_user = ProjectUser.new
    @available_users = current_company.users
  end
  
  def create
    @project = Project.find(params[:project_id])
    @project_user = ProjectUser.new(params[:project_user])
    @project_user.project = @project
    if @project_user.save
      redirect_to(project_path(@project), :notice => "#{@project_user.user.firstname} was successfully added to the project.")
    else
      render :action => "new"
    end
  end
  
  def destroy
    @project = Project.find(params[:project_id])
    @project_user = ProjectUser.find(params[:id])
    if @project_user.destroy
      redirect_to(project_path(@project), :notice => "The user was successfully removed.")
    else
      redirect_to(project_path(@project), :notice => "You cannot delete this user.")
    end
  end

end