module DateSplitter

  def get_dates(weeks_ago)
    dates = Array.new
    number_of_weeks_ago = weeks_ago+1
    ((number_of_weeks_ago*7)-7..(number_of_weeks_ago*7)-1).each do |d|
      start_date = d.days.ago
      dates << start_date.strftime("%A %e %b %Y")
    end
    dates.reverse
  end

  def find_between_dates(resource, options)
    if options[:weeks]
      dates = options[:weeks]
      if dates.class == Date
        resource = resource.where('date = ?', dates)
      else
        dates_list = get_dates(dates)
        resource = resource.where('date >= ? AND date <= ?', Date.parse(dates_list.first), Date.parse(dates_list.last))
      end
    end

    if options[:order]
      resource = resource.order(options[:order])
    end

    if options[:group_date_string]
      resource = resource.group_by { |group| group.date.strftime(options[:group_date_string]) }
    end

    if options[:weeks]
      output = Hash.new
      dates = options[:weeks]
      if dates.class == Date
        if !resource[dates.strftime("%A %e %b %Y")]
          output[dates] = []
        else
          output[dates.strftime("%A %e %b %Y")] = resource[dates.strftime("%A %e %b %Y")]
        end
      else
        get_dates(options[:weeks]).each do |date|
          if !resource[date]
            output[date] = []
          else
            output[date] = resource[date]
          end
        end
      end
      return output
    else
      return resource
    end
  end

end