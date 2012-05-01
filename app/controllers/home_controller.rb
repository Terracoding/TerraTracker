class HomeController < ApplicationController
  def index
  end
  def plans
    @plans = Plan.find(:all)
  end
end
