class Project < ActiveRecord::Base
  belongs_to :company
  validates_presence_of :name
  has_many :tasks, :dependent => :destroy
  
  def to_s
    name
  end
end
