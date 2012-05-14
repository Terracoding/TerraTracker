class HomeController < ApplicationController
  layout "home"
  def index
  end
  def plans
    @plans = Plan.find(:all)
  end
end
