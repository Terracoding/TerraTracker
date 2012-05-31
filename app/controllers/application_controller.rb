class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_up_path_for(resource)
    dashboard_index_path
  end

  def after_sign_in_path_for(resource)
    dashboard_index_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def current_company
    @current_company = current_user.company
  end

  def redirect_company
    current_company ? @current_company = current_company : redirect_to(new_company_path)
  end

  def redirect_sub_account
    redirect_to(dashboard_index_path) if current_user.sub_account
  end

  def redirect_non_admin
    redirect_to(dashboard_index_path) if !current_user.company_admin
  end

  def redirect_projects
    if current_company.projects.count < 1
      flash[:error] = 'You need to set up a project before you can create a task.'
      redirect_to(new_project_path)
    end
  end

  def validate_api_key(api_key, secret_key, user_id)
    app = DeveloperApplication.find_by_api_key(api_key)
    if app != nil
      if User.exists?(user_id)
        app.secret_key == secret_key && app.user == User.find(user_id) ? true : false
      else
        false
      end
    else
      false
    end
  end

end
