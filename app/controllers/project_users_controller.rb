class ProjectUsersController < ApplicationController
  before_filter :authenticate_user!, :redirect_company, :redirect_sub_account, :redirect_projects
  before_filter :get_available_users, :only => [:new, :create]

  def new
    @project = Project.find(params[:project_id])
    @project_user = ProjectUser.new
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
    if @project_user.user.company_admin
      flash[:error] = "You cannot remove a project manager from the project users."
      redirect_to project_path(@project)
    else
      @project_user.destroy
      redirect_to(project_path(@project), :notice => "The user was successfully removed.")
    end

  end

  private

  def get_available_users
    @available_users = current_company.users
  end

end
