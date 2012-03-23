class CompanyController < ApplicationController
  before_filter :authenticate_user!
  before_filter :redirect_company, :only => [:index, :update, :destroy]
  before_filter :redirect_sub_account
  
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
      redirect_to(company_index_path, :notice => "The company #{@company.name} was successfully created.")
    else
      render :action => "new"
    end
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      redirect_to(company_index_path, :notice => "The company #{@company.name} was successfully updated.")
    else
      render :action => "edit"
    end
  end
  
end