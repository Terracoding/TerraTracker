class User < ActiveRecord::Base
  before_create :check_beta_key
  validate :check_user_limit, :on => :create
  validates_presence_of :email
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :owns_company, :company, :company_admin, :current_password
  attr_accessor :beta_key
  attr_accessible :beta_key
  belongs_to :company
  has_many :project_users, :dependent => :destroy
  has_many :projects, :through => :project_users
  has_many :timeslips
  has_one  :subscription

  def check_beta_key
    if beta_key != "2873-8299-1726"
      self.errors[:base] << "The BETA key you have entered is incorrect."
      return false
    end
  end

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
