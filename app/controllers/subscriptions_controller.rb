class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!, :redirect_sub_account, :get_company
  
  def index
    @subscriptions = Subscription.find_by_user_id(current_user)
  end
  
  def new
    @subscription = Subscription.new
  end
  
  def create
    @subscription = Subscription.new(params[:subscription])
    @subscription.user = current_user
      if @subscription.save
        redirect_to subscriptions_path, :notice => "Signed up!"
      else
        render :action => :new
      end
    rescue Stripe::StripeError => e
      logger.error e.message
      @subscription.errors.add :base, "There was a problem with your credit card"
      @subscription.stripe_token = nil
      render :action => :new
  end
  
  def update
    #   current_user.update_attributes(params[:user])
    #   if current_user.save
    #     redirect_to root_path, :notice => "Profile updated"
    #   else
    #     render :action => :edit
    #   end
    # rescue Stripe::StripeError => e
    #   logger.error e.message
    #   @user.errors.add :base, "There was a problem with your credit card"
    #   @user.stripe_token = nil
    #   render :action => :edit
  end
  
  private

  def get_company
    if current_company
      @current_company = current_company
      @projects = @current_company.projects if @current_company.projects
    end
  end

end
