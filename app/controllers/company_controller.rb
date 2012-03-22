class CompanyController < ApplicationController

  def index
    current_company ? @current_company = current_company : redirect_to(new_company_path)
  end
  
  def new
    @company = Company.new
  end
  
  def edit
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
      redirect_to(application_path(@company), :notice => "#{@company.name} was successfully updated.")
    else
      render :action => "edit"
    end
  end
  
end
