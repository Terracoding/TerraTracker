class DashboardController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @current_company = current_company
  end
  
end
