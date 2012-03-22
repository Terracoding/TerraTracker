require 'spec_helper'

describe Company do
  describe "validations" do
    it { should belong_to(:user) }
  end
end
