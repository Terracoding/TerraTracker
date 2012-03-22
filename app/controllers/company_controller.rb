class CompanyController < ApplicationController
  before_filter :authenticate_user!, :confirm_company
  
  def index
    # @company_users.
  end
  
  def new
    @company = Company.new
  end
  
  def edit
    @company = Company.find(params[:id])
  end
  
  def create
    @company = Company.new(params[:company])
    @company.user = current_user
    if @company.save
      redirect_to(company_index_path :notice => "#{@company.name} was successfully created.")
    else
      render :action => "new"
    end
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      redirect_to(company_index_path, :notice => "#{@company.name} was successfully updated.")
    else
      render :action => "edit"
    end
  end
  
  private
  
  def confirm_company
    current_company ? @current_company = current_company : redirect_to(new_company_path)
  end
  
end