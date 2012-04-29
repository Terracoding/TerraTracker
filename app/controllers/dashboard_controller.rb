class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_company
      @current_company = current_company
      @projects = @current_company.projects if @current_company.projects
      @recent_timeslips = Timeslip.where(:user_id => current_user.id).limit(5).order("id DESC").reverse
    end
  end

end
