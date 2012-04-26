class ReportsController < ApplicationController
  include ReportsHelper
  before_filter :authenticate_user!, :redirect_company, :redirect_projects

  def index
    @projects = current_company.projects
    @tasks = current_company.tasks
    current_user.sub_account ? @users = [current_user] : @users = User.where("company_id = ?", current_user.company.id)
    @timeframes = [["This Week", 1], ["Last Week", 2], ["This Month", 3], ["Last Month", 4]]
    @report = Report.new
  end

  def generate_report
    @report = get_report_data(Report.new(params[:report]))
    @timeslips = get_timeslips(@report)
    @total_hours = 0
    @timeslips.each { |t| @total_hours += t.hours.to_f }
    render :index if !@report.valid?
  end

  def view_report
    @report = get_report_data(Report.new(params[:report]))
    @timeslips = get_timeslips(@report)
    if @report.valid?
      @pdf = ReportGenerator.new(@report, @timeslips, current_user)
      send_data @pdf.render, filename: "#{@report.company.name.parameterize.underscore}-report.pdf", type: "application/pdf", disposition: "inline"
    else
      render :index
    end
  end

  private

  def get_report_data(report)
    report.company = current_company
    report.project = Project.find(report.project_id) if Project.exists?(report.project_id)
    report.task = Task.find(report.task_id) if Task.exists?(report.task_id)
    report.user = User.find(report.user_id)
    report.timeframe = timeframe(report.timeframe_id)
    return report
  end

  def get_timeslips(report)
    timeslips = Timeslip.where(:user_id => report.user)
    timeslips = timeslips.where(:project_id => report.project_id) if report.project_id != ""
    timeslips = timeslips.where(:task_id => report.task_id) if report.task_id != ""
    return timeslips
  end

end
