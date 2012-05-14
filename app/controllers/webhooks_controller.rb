class WebhooksController < ApplicationController

  def receive_payload
    if params[:payload]
      respond_to { |format| format.json { render :json => "Got a payload?", :status => 200 }}
      if GoCardless.webhook_valid?(params[:payload])
        respond_to { |format| format.json { render :json => "Got it!", :status => 200 }}
      end
    else
      respond_to { |format| format.json { render :json => "Didn't get a payload: #{params.inspect}", :status => 200 }}
    end
  end

end