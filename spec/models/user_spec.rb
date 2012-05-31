require 'spec_helper'

describe User do
  
  describe "validations" do
    it { should belong_to(:company) }
    it { should have_many(:timeslips) }
    it { should have_many(:project_users).dependent(:destroy) }
    it { should have_many(:projects).through(:project_users) }
    it { should have_many(:developer_applications) }
  end
  
  context :to_s do
    it "should return the first and last name of the user" do
      user = User.new(:firstname => 'Test', :lastname => 'User')
      user.to_s.should == "Test User"
    end
  end

  context :check_user_limit do
    before(:each) do
      @valid_user = FactoryGirl.build(:user)
    end

    it "should does not return false if less than the user limit" do
      @valid_user.stub_chain(:company, :users, :count).and_return(1)
      @valid_user.stub_chain(:company, :plan, :user_count).and_return(4)
      @valid_user.save.should_not be_false
    end

    it "should return false if user limit met" do
      @valid_user.stub_chain(:company, :users, :count).and_return(2)
      @valid_user.stub_chain(:company, :plan, :user_count).and_return(2)
      @valid_user.save.should be_false
    end

    it "should provide an error message when returning false" do
      @valid_user.stub_chain(:company, :users, :count).and_return(2)
      @valid_user.stub_chain(:company, :plan, :user_count).and_return(2)
      @valid_user.save
      @valid_user.errors.full_messages.should include "You have reached your user limit. If you wish to add more users, please upgrade your account."
    end
  end

end
