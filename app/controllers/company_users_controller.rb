class CompanyUsersController < ApplicationController
  before_filter :authenticate_user!, :confirm_company
  
  # def index
  #   # @company_users.
  # end
  # 
  def new
    @company = @current_company
    @user = User.new
  end
  # 
  # def edit
  #   @company = Company.find(params[:id])
  # end
  # 
  def create
    @user = User.new(params[:user])
    @user.company = @current_company
    @user.sub_account = true
    if @user.save
      redirect_to company_index_path
    else
      render :action => "new"
    end
  end
  # 
  # def update
  #   @company = Company.find(params[:id])
  #   if @company.update_attributes(params[:company])
  #     redirect_to(company_index_path, :notice => "#{@company.name} was successfully updated.")
  #   else
  #     render :action => "edit"
  #   end
  # end
  # 
  private
  
  def confirm_company
    current_company ? @current_company = current_company : redirect_to(new_company_path)
  end
  
end