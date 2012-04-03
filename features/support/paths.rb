module NavigationHelpers

  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /^the dashboard page$/
      dashboard_index_path
    when /^the login page$/
      new_user_session_path
    when /^the company page$/
      company_index_path
    when /^the new company page$/
      new_company_path
    when /^the projects page$/
      projects_path
    when /^the timeslips page%/
      timeslips_path
    when /^the tasks page%/
      tasks_path
    when /^the reports page%/
      reports_path
    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
  
end

World(NavigationHelpers)
