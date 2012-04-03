class Subscription < ActiveRecord::Base
  belongs_to :user

  def available_plans
    [{ :id => 1, :name => "Starter $5.99/mo"}, { :id => 2, :name => "Basic $10.99/mo"}, { :id => 3, :name => "Professional $19.99/mo"}]
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
