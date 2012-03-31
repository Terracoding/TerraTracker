class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :owns_company, :company
  
  belongs_to :company
  has_many :project_users, :dependent => :destroy
  has_many :projects, :through => :project_users
  has_many :timeslips
  
  def to_s
    "#{firstname} #{lastname}"
  end
end
