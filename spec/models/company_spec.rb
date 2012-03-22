require 'spec_helper'

describe Company do
  describe "validations" do
    it { should belong_to(:user) }
    it { should have_many(:company_users) }
  end
end
