class CompanyUsersController < ApplicationController
  before_filter :authenticate_user!, :confirm_company
  
  def index
    
  end
  
  def new
    @company_user = CompanyUser.new
  end
  
  def create
    @company_user = CompanyUser.new(params[:company_user])
    @company_user.company = @current_company
    if @company_user.save
      redirect_to(company_index_path :notice => "#{@company_user.firstname} was successfully created.")
    else
      render :action => "new"
    end
  end

  private
  
  def confirm_company
    current_company ? @current_company = current_company : redirect_to(new_company_path)
  end
  
end