class Company < ActiveRecord::Base
  belongs_to :user
  has_many :users
  has_many :projects
  has_many :tasks, :through => :projects
  has_many :timeslips, :through => :projects
  
  def tasks_count
    count = 0
    projects.each do |project|
      count += project.tasks.count
    end
    return count
  end

end
