class WebhooksController < ApplicationController

  def process
    if GoCardless.webhook_valid?(params[:payload])
      puts "GOT A WEBHOOK"
    end
  end

end