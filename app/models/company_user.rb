class CompanyUser < ActiveRecord::Base
  belongs_to :company
  
  validates_uniqueness_of :email
  validates_presence_of :email

  validates :email,
            :presence => true,
            :uniqueness => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :company, :email, :password, :password_confirmation, :remember_me, :firstname, :lastname
end
