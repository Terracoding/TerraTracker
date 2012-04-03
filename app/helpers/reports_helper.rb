module ReportsHelper

  def timeframe(timeframe)
    case timeframe.to_i
    when 1
      "This Week"
    when 2
      "Last Week"
    when 3
      "This Month"
    when 4
      "Last Month"
    end
  end

end