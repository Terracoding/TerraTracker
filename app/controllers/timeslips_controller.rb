class TimeslipsController < ApplicationController
  include DateSplitter
  before_filter :authenticate_user!, :redirect_company, :redirect_projects

  def index
    if params[:year] && params[:month] && params[:day]
      @date = Date.parse("#{params[:day]}/#{params[:month]}/#{params[:year]}")
    else
      @date = Date.today
    end
    if params[:view] == "day"
      @previous = @date - 1.day
      @next = @date + 1.day
    else
      @previous = @date - 1.week
      @next = @date + 1.week
    end
    if current_user.sub_account
      @timeslips = find_current_week(current_user.timeslips, { :date => @date, :order => "date, id ASC", :view => params[:view] })
    else
      @timeslips = find_current_week(current_company.timeslips, { :date => @date, :order => "date, id ASC", :view => params[:view] })
    end
  end

  def new
    @timeslip = Timeslip.new(:date => Date.today)
    @tasks = current_company.tasks
    p = Project.where("company_id = ? AND archived = false", current_company.id)
    @projects = []
    p.each { |project| @projects << project if project.tasks.count > 0 }
    current_user.sub_account ? @users = [current_user] : @users = User.where("company_id = ?", current_user.company.id)
  end

  def edit
    @timeslip = Timeslip.find(params[:id])
  end

  def create
    @timeslip = Timeslip.new(params[:timeslip])
    if @timeslip.save
      redirect_to(timeslips_path, :notice => "The timeslip was successfully created.")
    else
      render :action => "new"
    end
  end

  def update
    @timeslip = Timeslip.find(params[:id])
    if @timeslip.update_attributes(params[:timeslip])
      redirect_to(timeslips_path, :notice => "The timeslip was successfully updated.")
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @timeslip = Timeslip.find(params[:id])
    if !current_user.sub_account || current_user == @timeslip.user
      @timeslip.destroy 
      redirect_to(timeslips_path, :notice => "The timeslip was successfully removed.")
    else
      flash[:error] = "You are not permitted to remove this timeslip."
      render :action => "index"
    end
  end

  def get_tasks
    @tasks = Task.where(:project_id => params[:project_id])
    render :json => @tasks
  end

  def get_users
    @users = ProjectUser.where(:project_id => params[:project_id])
    @users.map! { |current| current = current.user }
    render :json => @users
  end
end