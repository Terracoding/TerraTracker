require 'spec_helper'

describe ReportsHelper do
  
  context :timeframe do
    it "should return this week" do
      timeframe(1).should == "This Week"
    end
    it "should return last week" do
      timeframe(2).should == "Last Week"
    end
    it "should return this month" do
      timeframe(3).should == "This Month"
    end
    it "should return last month" do
      timeframe(4).should == "Last Month"
    end
  end

end
