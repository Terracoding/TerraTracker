#coding: utf-8
class Subscription < ActiveRecord::Base
  belongs_to :user

  def available_plans
    [{ :id => 1, :name => "Starter £8/month"}, { :id => 2, :name => "Basic £16/month"}, { :id => 3, :name => "Professional £32/month"}]
  end

  def to_s
    case plan_id
      when 1
        "Starter"
      when 2
        "Basic"
      when 3
        "Professional"
      else
        "Free"
    end
  end

  def projects_limit
    case plan_id
      when 1
        2
      when 2
        10
      when 3
        30
      else
        1
    end
  end

  def users_limit
    case plan_id
      when 1
        2
      when 2
        15
      when 3
        100
      else
        1
    end
  end

end
