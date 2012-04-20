class Bill < ActiveRecord::Base
  validates_presence_of :reference_id
  validates_presence_of :bill_date
  validates_presence_of :due_date
  validates_presence_of :value
  belongs_to :user
  belongs_to :company
end
