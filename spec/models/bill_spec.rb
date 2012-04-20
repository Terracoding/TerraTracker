require 'spec_helper'

describe Bill do
  context :validations do
    it { should validate_presence_of :reference_id }
    it { should validate_presence_of :bill_date }
    it { should validate_presence_of :due_date }
    it { should validate_presence_of :value }
    it { should belong_to :user }
    it { should belong_to :company }
  end
end
