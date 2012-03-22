require 'spec_helper'

describe Company do
  describe "validations" do
    it { should have_many(:users) }
  end
end
