module DatePagination

  def get_dates(date)
    dates = Array.new
    start_date = get_start_date(date)
    (0..6).each { |i| dates << (start_date + i).strftime("%A %e %b %Y") }
    return dates
  end

  def get_start_date(date)
    return date - (date.cwday - 1)
  end

  def get_end_date(date)
    return date + (7 - date.cwday)
  end

  def find_current_week(resource, options)
    options[:include_empty] ? include_empty = options[:include_empty] : include_empty = true
    options[:date] ? date = options[:date] : date = Date.today
    options[:group_date_string] ? group_date_string = options[:group_date_string] : group_date_string = "%A %e %b %Y"
    if (options[:view] == "day")
      @resource = resource.where('date = ?', options[:date])
    else
      @resource = resource.where('date >= ? AND date <= ?', get_start_date(options[:date]), get_end_date(options[:date]))
    end
    @resource = @resource.order(options[:order]) if options[:order]
    @resource = @resource.group_by { |group| group.date.strftime(group_date_string) }
    @resource = include_empty_dates(date) if include_empty == true && options[:view] != "day"
    return @resource
  end

  private

  def include_empty_dates(date)
    resource_with_empty = Hash.new
    get_dates(date).each { |d| @resource[d] ? resource_with_empty[d] = @resource[d] : resource_with_empty[d] = [] }
    return resource_with_empty
  end

end