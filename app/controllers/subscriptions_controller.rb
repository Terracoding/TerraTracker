class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!, :redirect_sub_account, :get_company

  def index
    @subscription = Subscription.find_by_user_id(current_user.id)
    if @subscription
      @merchant_subscription = GoCardless::Subscription.find(@subscription.resource_id)
      Subscription.destroy(current_user.subscription) if !@merchant_subscription
    end
    @plans = Plan.find(:all)
  end

  def confirm_subscription
    begin
      @confirmation = GoCardless.confirm_resource(params)
      if @confirmation
        cancel
        Subscription.destroy(current_user.subscription) if Subscription.exists?(current_user.subscription)
        @subscription = Subscription.create!(
          :user => current_user,
          :resource_uri => params[:resource_uri],
          :resource_id => params[:resource_id],
          :resource_type => params[:resource_type],
          :signature => params[:signature],
          :subscribed => true,
          :merchant_id => @confirmation.merchant_id,
          :subscription_acount => @confirmation.amount,
          :resource_user_id => @confirmation.user_id,
          :plan_id => get_plan_id(@confirmation.amount)
        )
        flash[:notice] = "You have successfully subscribed to the #{@subscription.to_s} plan."
      end
    rescue GoCardless::ApiError => e
      flash[:error] = e
    end
  end

  def cancel
    @subscription = Subscription.find_by_user_id(current_user.id)
    if @subscription
      s = GoCardless::Subscription.find(@subscription.resource_id)
      if s.cancel!
        @subscription.delete
        flash[:notice] = "You have cancelled your subscription!"
      end
    end
    redirect_to subscriptions_path
  end

  private

  def get_company
    if current_company
      @current_company = current_company
      @projects = @current_company.projects if @current_company.projects
    end
  end

  def get_plan_id(amount)
    case amount
    when "8.0"
      return 1
    when "16.0"
      return 2
    when "32.0"
      return 3
    else
      return 0
    end
  end
end
