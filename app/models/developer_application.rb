class DeveloperApplication < ActiveRecord::Base
  before_create :create_keys
  belongs_to :user
  validates :name, :description, :presence => true
  
  def create_keys
    self.api_key = ActiveSupport::SecureRandom.hex(16)
    self.secret_key = ActiveSupport::SecureRandom.hex(16)
  end
end
