class DeveloperController < ApplicationController
  before_filter :authenticate_user!, :redirect_sub_account

  def index
    @applications = DeveloperApplication.where(:user_id => current_user)
  end

  def show
    @application = DeveloperApplication.find(params[:id])
  end

  def new
    @application = DeveloperApplication.new
  end

  def edit
    @application = DeveloperApplication.find(params[:id])
  end

  def create
    @application = DeveloperApplication.new(params[:developer_application])
    @application.user = current_user
    if @application.save
      redirect_to(developer_index_path, :notice => "The application was successfully created.")
    else
      render :action => "new"
    end
  end

  def update
    @application = DeveloperApplication.find(params[:id])
    if @application.update_attributes(params[:developer_application])
      redirect_to(developer_index_path, :notice => "The application was successfully updated.")
    else
      render :action => "edit"
    end
  end

  def destroy
    @application = DeveloperApplication.find(params[:id])
    @application.destroy
    redirect_to(developer_index_path, :notice => "The application was successfully removed.")
  end
end
