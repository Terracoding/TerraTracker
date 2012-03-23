class TimeslipsController < ApplicationController
  before_filter :authenticate_user!, :redirect_company
  
  def index
    
  end
  
end
