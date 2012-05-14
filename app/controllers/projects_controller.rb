class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :redirect_company, :redirect_sub_account
  
  def index
    @all_projects = Project.where(:company_id => current_company.id)
    @projects = @all_projects.where(:archived => false)
    @archived_projects_count = @all_projects.where(:archived => true).count
  end

  def archived
    @projects = Project.where(:company_id => current_company.id, :archived => true)
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
    @archived_count = current_user.projects.where(:archived => true).count
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
    respond_to do |format|
      format.html { redirect_to(projects_path, :notice => "The project was successfully removed.") }
      format.js
    end
  end

end
