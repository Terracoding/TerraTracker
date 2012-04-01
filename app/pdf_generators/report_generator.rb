class ReportGenerator < Prawn::Document

  def initialize(report)
    super(top_margin: 70)
    @report = report
    display_header
    move_down 25
    display_table
  end

  private

  def display_header
    fill_color "777777"
    text "Timesheet for #{@report.user.to_s}", size: 14, style: :bold, :align => :right
    fill_color "000000"
    text @report.company.name, size: 24, style: :bold, :align => :left
    move_down 5
  end

  def display_table
    t = make_table([['hello']])
    t.draw
    move_down 20
  end

end
