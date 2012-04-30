class Plan < ActiveRecord::Base
  validates_presence_of :title, :description, :value, :duration, :project_count, :user_count

  has_many :subscriptions
  has_many :companies

  def generate_new_url
    GoCardless.new_subscription_url(
      :amount => self.value,
      :name => self.title,
      :interval_unit => "month",
      :interval_length => 1,
    )
  end
end
