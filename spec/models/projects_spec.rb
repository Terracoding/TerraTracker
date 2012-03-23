require 'spec_helper'

describe Project do
  describe "validations" do
    it { should belong_to(:company) }
    it { should validate_presence_of(:name) }
  end
end
