class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    if current_company
      @current_company = current_company
      @projects = @current_company.projects if @current_company.projects
      @subscription = Subscription.find_by_user_id(current_user.id)
    end
  end
  
end
