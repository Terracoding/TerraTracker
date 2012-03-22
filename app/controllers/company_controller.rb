class CompanyController < ApplicationController

  def index
    redirect_to new_company_path if !@company
  end
  
  def new
    @company = Company.new
  end
  
  def edit
  end
  
  def create
    # Untested
    @company = Company.new(params[:company])
    if @company.save
      redirect_to(company_index_path :notice => "#{@company.name} was successfully created.")
    else
      render :action => "new"
    end
  end

  def update
    # Untested
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      redirect_to(application_path(@company), :notice => "#{@company.name} was successfully updated.")
    else
      render :action => "edit"
    end
  end
  
end
