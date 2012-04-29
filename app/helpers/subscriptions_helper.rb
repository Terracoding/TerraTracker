module SubscriptionsHelper

  def current_plan(plan)
    @subscription.to_s.downcase == plan.title
  end

end
