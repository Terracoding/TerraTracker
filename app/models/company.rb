class Company < ActiveRecord::Base
  belongs_to :user
  has_many :company_users
end
