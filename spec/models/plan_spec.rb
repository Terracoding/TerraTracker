require 'spec_helper'

describe Plan do
  context :validations do
    it { should have_many(:subscriptions) }
    it { should have_many(:companies).through(:subscriptions) }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:project_count) }
    it { should validate_presence_of(:user_count) }

    it "generates a new GoCardless URL" do
      GoCardless.stub(:new_subscription_url).and_return("foo")
      Plan.new.generate_new_url.should == "foo"
    end
  end
end
