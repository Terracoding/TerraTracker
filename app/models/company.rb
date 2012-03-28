class Company < ActiveRecord::Base
  has_many :users
  has_many :projects
  
  def tasks_count
    count = 0
    projects.each do |project|
      count += project.tasks.count
    end
    return count
  end
end
