class CompanyUsersController < ApplicationController
  before_filter :authenticate_user!, :redirect_company

  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    @user.company = @current_company
    @user.sub_account = true
    if @user.save
      redirect_to company_index_path, :notice => "You have successfully added #{@user.firstname} #{@user.lastname} to your company."
    else
      render :action => "new"
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if !@user.owns_company? && @user.sub_account
      @user.destroy
      redirect_to(company_index_path, :notice => "The user was successfully removed.")
    else
      redirect_to(company_index_path, :notice => "You cannot delete this user.")
    end
  end

end