module ReportsHelper

  def get_timeslips_with_timeframe(timeslips, timeframe)
    if timeframe == "This Week"
      timeslips.where("date > ?", Time.now - 1.week)
    elsif timeframe == "Last Week"
      timeslips.where("date > ? AND date < ?", Time.now - 2.week, Time.now - 1.week)
    elsif timeframe == "This Month"
      timeslips.where("date > ?", Time.now - 1.month)
    elsif timeframe == "Last Month"
      timeslips.where("date > ? AND date < ?", Time.now - 2.months, Time.now - 1.month)
    else
      timeslips
    end
  end

  def get_timeslips_with_dates(timeslips, start_date, end_date)
    timeslips.where("date >= ? AND date <= ?", Date.parse(start_date), Date.parse(end_date))
  end
end