class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!, :redirect_sub_account, :get_company

  def index
    @subscription = Subscription.find_by_company_id(@current_company.id)
    if @subscription
      begin
        @merchant_subscription = GoCardless::Subscription.find(@subscription.resource_id)
      rescue GoCardless::ApiError => e
        if e.code == 404
          current_company.subscription.unsubscribe
          flash.now[:error] = "There was a problem with your subscription. Please contact support for further information."
        else
          flash.now[:error] = e.to_s
        end
      end
    end
    @plans = Plan.find(:all)
    @project_disabled = current_company.plan.project_count >= current_company.projects.count
    @user_disabled = current_company.plan.user_count >= current_company.users.count
  end

  def confirm_subscription
    begin
      @confirmation = GoCardless.confirm_resource(params)
      if @confirmation
        cancel
        Subscription.destroy(@current_company.subscription) if Subscription.exists?(@current_company.subscription)
        @subscription = Subscription.create!(
          :company => current_company,
          :resource_uri => params[:resource_uri],
          :resource_id => params[:resource_id],
          :resource_type => params[:resource_type],
          :signature => params[:signature],
          :subscribed => true,
          :merchant_id => @confirmation.merchant_id,
          :subscription_acount => @confirmation.amount,
          :resource_user_id => @confirmation.user_id
        )
        @current_company.update_attribute(:plan, Plan.find_by_value(@confirmation.amount))
        flash[:notice] = "You have successfully subscribed to the #{@current_company.plan.title.capitalize} plan."
      end
    rescue GoCardless::ApiError => e
      flash[:error] = e.to_s
    end
  end

  def cancel
    @subscription = Subscription.find_by_company_id(@current_company.id)
    if @subscription
      s = GoCardless::Subscription.find(@subscription.resource_id)
      if s.cancel!
        @subscription.delete
        @current_company.update_attribute(:plan, Plan.find(1))
        project_limit = Plan.find(1).project_count
        projects = @current_company.projects.where(:archived => false)
        counter = 0
        projects.each do |project|
          if !project.archived
            counter += 1
            project.archived = true if counter > project_limit
            project.save
          end
        end
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
end
