class Subscription < ActiveRecord::Base
  attr_accessible :stripe_token, :last_4_digits, :credit_card_number, :plan_id
  attr_accessor :stripe_token
  belongs_to :user
  before_save :update_stripe

  def available_plans
    [{ :id => 1, :name => "Starter $5.99/mo"}, { :id => 2, :name => "Basic $10.99/mo"}, { :id => 3, :name => "Professional $19.99/mo"}]
  end

  def update_stripe
    if stripe_token.present?
      if stripe_id.nil?
        customer = Stripe::Customer.create(
          :description => user.email,
          :card => stripe_token
        )
        self.last_4_digits = customer.active_card.last4
        response = customer.update_subscription({:plan => plan_id})
      else
        customer = Stripe::Customer.retrieve(stripe_id)
        customer.card = stripe_token
        customer.save
        self.last_4_digits = customer.active_card.last4
      end

      self.stripe_id = customer.id
      self.stripe_token = nil
    elsif last_4_digits_changed?
      self.last_4_digits = last_4_digits_was
    end
  end
  
  def to_s
    case plan_id
      when 1
        "Starter"
      when 2
        "Basic"
      when 3
        "Professional"
      else
        "Free"
    end
  end

end
