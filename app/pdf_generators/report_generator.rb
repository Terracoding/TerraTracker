class ReportGenerator < Prawn::Document

  def initialize(report)
    super(top_margin: 70)
    @report = report
    display_header
    move_down 25
  end

  private

  def display_header
    text @report.company.name, size: 24, style: :bold, :align => :left
    text "#{@report.user.to_s} Timetracking Sheet", size: 15, style: :bold
    move_down 5
    text "Report"
  end

end
