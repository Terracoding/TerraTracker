class Timeslip < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  belongs_to :project
  validates_presence_of :task
  validates_presence_of :user
  validates_presence_of :project

  def hours=(hours)
    if hours.to_s =~ /:/
      time_split = hours.split(':')
      time_mins = time_split[1].to_f / 60
      self.hours = time_split[0].to_f + time_mins
    else
      super
    end
  end
end
