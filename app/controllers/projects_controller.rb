class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :redirect_company, :redirect_sub_account
  
  def index
    
  end
  
end
