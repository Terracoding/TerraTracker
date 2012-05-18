module DateSplitter

  def get_dates(weeks_ago)
    dates = Array.new
    weeks_ago += 1
    ((weeks_ago*7)-7..(weeks_ago*7)-1).each { |d| dates << d.days.ago.strftime("%A %e %b %Y") }
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

    resource = resource.order(options[:order]) if options[:order]
    resource = resource.group_by { |group| group.date.strftime(options[:group_date_string]) } if options[:group_date_string]

    if options[:weeks]
      output = Hash.new
      dates = options[:weeks]
      if dates.class == Date
        dates_str = dates.strftime("%A %e %b %Y")
        resource[dates_str] ? output[dates_str] = resource[dates_str] : output[dates] = []
      else
        get_dates(dates).each { |date| resource[date] ? output[date] = resource[date] : output[date] = [] }
      end
      return output
    else
      return resource
    end
  end

end