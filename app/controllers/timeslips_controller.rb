class TimeslipsController < ApplicationController
  before_filter :authenticate_user!, :redirect_company, :redirect_projects
  
  def index
    current_user.sub_account ? @timeslips = current_user.timeslips : @timeslips = current_company.timeslips
  end
  
  def new
    @timeslip = Timeslip.new
    @tasks = current_company.tasks
    @projects = current_company.projects
    current_user.sub_account ? @users = [current_user] : @users = User.where("company_id = ?", current_user.company.id)
  end
  
  def create
    @timeslip = Timeslip.new(params[:timeslip])
    if @timeslip.save
      redirect_to(timeslips_path, :notice => "The timeslip was successfully created.")
    else
      render :action => "new"
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
  
end
