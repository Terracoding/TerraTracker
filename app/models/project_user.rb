class ProjectUser < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates_presence_of :project_id
  validates_presence_of :user_id
  validates_uniqueness_of :user_id, :scope => :project_id
end
