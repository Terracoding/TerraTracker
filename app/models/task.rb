class Task < ActiveRecord::Base
  belongs_to :project
  has_many :timeslips
  validates_presence_of :name
  validates_presence_of :project
end
