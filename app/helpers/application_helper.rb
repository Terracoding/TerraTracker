module ApplicationHelper

  def twitterized_type(type)
    case type
      when :alert
        "alert alert-block"
      when :error
        "alert alert-error"
      when :notice
        "alert alert-success"
      else
        "alert alert-info"
    end
  end

end
