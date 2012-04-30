module SubscriptionsHelper

  def current_plan(plan)
    @current_company.plan.title.downcase == plan.title
  end

end
