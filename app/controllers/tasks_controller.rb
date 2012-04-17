class TasksController < ApplicationController
  before_filter :authenticate_user!, :redirect_company, :redirect_projects
  before_filter :can_manage, :except => [:index]
  
  def index
    @tasks = Task.joins(:project).where("projects.company_id" => current_company.id)
  end
  
  def new
    @task = Task.new
    @available_projects = current_company.projects
  end

  def edit
    @task = Task.find(params[:id])
    @available_projects = current_company.projects
  end

  def create
    @task = Task.new(params[:task])
    @task.project = Project.find(params[:task][:project_id])
    if @task.save
      redirect_to(tasks_path, :notice => "The task #{@task.name} was successfully created.")
    else
      render :action => :new
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.project = Project.find(params[:task][:project_id])
    if @task.update_attributes(params[:task])
      redirect_to(tasks_path, :notice => "The task was successfully updated.")
    else
      render :action => "edit"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to(tasks_path, :notice => "The task was successfully removed.") }
      format.js
    end
  end
  
  private

  def can_manage
    if current_user.sub_account
      redirect_to tasks_path
    else
      return true
    end
  end

end
