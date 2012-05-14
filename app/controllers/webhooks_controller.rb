class WebhooksController < ApplicationController

  def receive_payload
    if params[:payload]
      GoCardless.webhook_valid?(params[:payload]) ?  valid_payload : invalid_payload
    else
      no_payload
    end
  end

  private

  def no_payload
    respond_to { |format| format.json { render :json => "No payload found", :status => 401 }}
  end

  def invalid_payload
    respond_to { |format| format.json { render :json => "Invalid payload", :status => 401 }}
  end

  def valid_payload
    @payload = params[:payload]
    if @payload[:action] == "cancelled"
      cancel_subscription
    else
      respond_to { |format| format.json { render :json => "Nothing to change", :status => 200 }}
    end
  end

  def cancel_subscription
    subscriptions_cancelled = 0
    @payload[:subscriptions].each do |resource|
      if resource[:status] == "cancelled"
        subscription = Subscription.find_by_resource_id(resource[:id])
        if subscription
          company = Company.find(subscription.company_id)
          company.update_attribute(:plan_id, 1)
          # Archive projects
          # Make company remove/disable some project users
          subscription.delete
          subscriptions_cancelled += 1
        end
      end
    end
    respond_to { |format| format.json { render :json => "#{subscriptions_cancelled} successfully cancelled", :status => 200 }}
  end

end