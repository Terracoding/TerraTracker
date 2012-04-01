class ReportsController < ApplicationController
  before_filter :authenticate_user!, :redirect_company, :redirect_projects

  def index
    @projects = current_company.projects
    @tasks = current_company.tasks
    current_user.sub_account ? @users = [current_user] : @users = User.where("company_id = ?", current_user.company.id)
    @timeframes = [["This Week", 1], ["Last Week", 2], ["This Month", 3], ["Last Month", 4]]
  end

  def create
    @project = Project.find(params[:report][:project])
    @task = Task.find(params[:report][:task])
    @user = User.find(params[:report][:user])
    @timeframe = timeframe(params[:report][:timeframe])
  end

  private

  def timeframe(timeframe)
    case timeframe.to_i
    when 1
      "This Week"
    when 2
      "Last Week"
    when 3
      "This Month"
    when 4
      "Last Month"
    end
  end

end
