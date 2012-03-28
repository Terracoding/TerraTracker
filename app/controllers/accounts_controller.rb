class AccountsController < ApplicationController
    before_filter :authenticate_user!
    
    def index
      if current_company
        @current_company = current_company
        @projects = @current_company.projects if @current_company.projects
      end
    end
end
