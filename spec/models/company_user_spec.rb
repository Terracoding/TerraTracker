require 'spec_helper'

describe CompanyUser do
  
  describe "validations" do
    it { should belong_to(:company) }
  end
end
