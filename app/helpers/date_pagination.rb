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

  def date_paginate(resource, options={})
    options.has_key?(:include_empty) ? include_empty = options[:include_empty] : include_empty = true
    options.has_key?(:date) ? date = options[:date] : date = Date.today
    options.has_key?(:group_date_string) ? date_format = options[:group_date_string] : date_format = "%A %e %b %Y"
    view = options[:view]
    @resource = resource_with_date(resource, date, view)
    @resource = @resource.order(options[:order]) if options[:order]
    @resource = @resource.group_by { |group| group.date.strftime(date_format) } # Make sure it works for any date object
    @resource = include_empty_dates(date, view, date_format) if include_empty == true
    return @resource
  end

  private

  def resource_with_date(resource, date, view)
    view == "day" ? resource.where('date = ?', date) : resource.where('date >= ? AND date <= ?', get_start_date(date), get_end_date(date))
  end

  def include_empty_dates(date, view, date_format)
    resource_with_empty = Hash.new
    if view == "day"
      string_date = date.strftime(date_format)
      @resource[string_date] ? resource_with_empty[string_date] = @resource[string_date] : resource_with_empty[string_date] = []
    else
      get_dates(date).each { |d| @resource[d] ? resource_with_empty[d] = @resource[d] : resource_with_empty[d] = [] }
    end
    return resource_with_empty
  end

end