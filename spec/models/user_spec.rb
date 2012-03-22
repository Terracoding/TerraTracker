require 'spec_helper'

describe User do
  
  describe "validations" do
    it { should belong_to(:company) }
  end

end
