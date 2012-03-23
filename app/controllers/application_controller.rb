class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_up_path_for(resource)
    resource.owns_company ? company_path : dashboard_index_path
  end
  
  def after_sign_in_path_for(resource)
    dashboard_index_path
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  def current_company
    current_user.company
  end
  
  def redirect_company
    current_company ? @current_company = current_company : redirect_to(new_company_path)
  end
  
  def redirect_sub_account
    redirect_to(dashboard_index_path) if current_user.sub_account
  end
end
