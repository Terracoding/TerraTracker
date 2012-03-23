require 'spec_helper'

describe Company do
  describe "validations" do
    it { should have_many(:users) }
    it { should have_many(:projects) }
  end
end
