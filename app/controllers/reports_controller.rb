class ReportsController < ApplicationController
  before_filter :authenticate_user!, :redirect_company, :redirect_projects
  
  def index
    
  end
end
