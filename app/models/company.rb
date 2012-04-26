class Company < ActiveRecord::Base
  belongs_to :user
  has_many :users
  has_many :projects
  has_many :tasks, :through => :projects
  has_many :timeslips, :through => :projects
  has_one :image
  has_attached_file :image,
    :styles => { :logo => "300x67#", :medium => "300x300>", :thumb => "150x34#"},
    :url => "/system/company_logos/:attachment/:id/:style/:filename",
    :path => ":rails_root/public/system/company_logos/:attachment/:id/:style/:filename"
  
  def tasks_count
    count = 0
    projects.each do |project|
      count += project.tasks.count
    end
    return count
  end

end
