class ReportGenerator < Prawn::Document

  def initialize(report, timeslips, user)
    super(top_margin: 70)
    @report = report
    @timeslips = timeslips
    @current_user = user
    display_header
    move_down 25
    display_table
    display_total_hours
    display_signatures
  end

  private

  def display_header
    fill_color "000000"
    if @current_user.company.image.path(:thumb)
      image @current_user.company.image.path(:thumb)
    else
      text @report.company.name, size: 24, style: :bold, :align => :left
      move_down 5
    end
    text "Timesheet for #{@report.user.to_s}", size: 14, style: :bold, :align => :right
  end

  def display_table
    table_info = [["Date", "Project", "Task", "Comment", "Hours", ]]
    @timeslips.each do |t|
      table_info << [
        t.date.strftime("%e %b %y"),
        t.project.to_s,
        t.task.name,
        t.comment,
        t.hours]
    end
    table = make_table table_info,
    :header => true,
    :cell_style => { :borders => [:bottom], :border_color => "DDDDDD", :size => 11 },
    :column_widths => [70, 90, 130, 200, 50]
    table.rows(0).style(:text_color => "FFFFFF", :background_color => "000000")
    table.draw
    move_down 15
  end

  def display_total_hours
    total_hours = 0
    @timeslips.each { |t| total_hours += t.hours if t.hours != nil }
    text "Total Hours: #{total_hours}", size: 11, style: :bold, :align => :right
    move_down 25
  end

  def display_signatures
    text "_____________________________________", size: 10
    move_down 5
    text "Consultant Signature             Date", size: 10
    move_down 20
    text "_____________________________________", size: 10
    move_down 5
    text "Approver Signature               Date", size: 10
  end

end
