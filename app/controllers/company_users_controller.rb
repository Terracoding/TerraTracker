class CompanyUsersController < ApplicationController
  before_filter :authenticate_user!, :redirect_company

  def new
    @company = @current_company
    @user = User.new
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

end