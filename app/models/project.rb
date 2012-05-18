class Project < ActiveRecord::Base
  validate :check_project_limit, :on => :update
  validate :check_project_creation, :on => :create
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

  private

  def check_project_limit
    if archived_was == true && company.plan.project_count <= company.projects.where(:archived => false).count
      self.errors[:base] << "You have reached your project limit. If you wish to add more projects, please upgrade your account."
      return false
    end
  end

  def check_project_creation
    if company.plan.project_count <= (company.projects.count - company.projects.where(:archived => true).count)
      self.errors[:base] << "You have reached your project limit. If you wish to add more projects, please upgrade your account."
      return false
    end
  end
end
