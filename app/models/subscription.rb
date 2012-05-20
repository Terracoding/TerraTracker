#coding: utf-8
class Subscription < ActiveRecord::Base
  belongs_to :company

  def unsubscribe
    company.plan_id = 1
    company.save
    self.subscribed = 0
    save
  end

end
