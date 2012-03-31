require 'spec_helper'

describe User do
  
  describe "validations" do
    it { should belong_to(:company) }
    it { should have_many(:timeslips) }
    it { should have_many(:project_users).dependent(:destroy) }
    it { should have_many(:projects).through(:project_users) }
  end
  
  context :to_s do
    it "should return the first and last name of the user" do
      user = User.new(:firstname => 'Test', :lastname => 'User')
      user.to_s.should == "Test User"
    end
  end

end
