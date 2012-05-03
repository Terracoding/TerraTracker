class User < ActiveRecord::Base
  validate :check_user_limit
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :owns_company, :company, :company_admin

  belongs_to :company
  has_many :project_users, :dependent => :destroy
  has_many :projects, :through => :project_users
  has_many :timeslips
  has_one  :subscription

  def to_s
    "#{firstname} #{lastname}"
  end

  private

  def check_user_limit
    if company && company.plan.user_count <= company.users.count
      self.errors[:base] << "You have reached your user limit. If you wish to add more users, please upgrade your account."
      return false
    end
  end

end
