class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :redirect_company, :redirect_sub_account
  
  def index
    @projects = Project.where(:company_id => current_company.id)
  end
  
  def show
    @project = Project.find(params[:id])
    @tasks = @project.tasks
  end
  
  def new
    @project = Project.new
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def create
    @project = Project.new(params[:project])
    @project.company = current_company
    ProjectUser.create(:project => @project, :user => current_user)
    if @project.save
      redirect_to(project_path(@project), :notice => "The project #{@project.name} was successfully created.")
    else
      render :action => "new"
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to(projects_path, :notice => "The project was successfully updated.")
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to(projects_path, :notice => "The project was successfully removed.")
  end
  
end
