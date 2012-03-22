class CompanyController < ApplicationController
  before_filter :authenticate_user!, :confirm_company
  before_filter :confirm_company, :only => [:index, :update, :destroy]
  before_filter :sub_account
  
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
    if @company.save
      current_user.company = @company
      current_user.owns_company = true
      current_user.save
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
  
  def sub_account
     redirect_to(dashboard_index_path) if current_user.sub_account
  end
  
end