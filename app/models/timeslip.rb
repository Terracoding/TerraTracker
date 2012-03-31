class Timeslip < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  belongs_to :project
  validates_presence_of :task
  validates_presence_of :user
  validates_presence_of :project
end
