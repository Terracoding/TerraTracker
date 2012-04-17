class Project < ActiveRecord::Base
  belongs_to :company
  validates_presence_of :name
  has_many :tasks, :dependent => :destroy
  has_many :project_users, :dependent => :destroy
  has_many :users, :through => :project_users
  has_many :timeslips, :dependent => :destroy

  def to_s
    name
  end

  def available_statuses
    ["Active","Completed","Cancelled"]
  end
end
