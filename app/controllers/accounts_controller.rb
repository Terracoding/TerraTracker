class AccountsController < ApplicationController
  before_filter :authenticate_user!, :redirect_sub_account, :get_company

  def index

  end

  private

  def get_company
    if current_company
      @current_company = current_company
      @projects = @current_company.projects if @current_company.projects
    end
  end

end
