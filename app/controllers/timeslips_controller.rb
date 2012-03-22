class TimeslipsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    current_company ? @current_company = current_company : redirect_to(new_company_path)
  end
  
end
