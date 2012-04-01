class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :company
  belongs_to :task
  attr_accessible :timeframe
end
