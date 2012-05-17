require 'spec_helper'

describe ReportsHelper do

  context :get_timeslips_with_timeframe do
    before :each do
      company = FactoryGirl.create(:company)
      user = FactoryGirl.create(:user, :company => company, :owns_company => true)
      project = FactoryGirl.create(:project, :company => company)
      FactoryGirl.create(:timeslip, :project => project, :user => user, :date => Date.today)
      FactoryGirl.create(:timeslip, :project => project, :user => user, :date => 1.week.ago)
      FactoryGirl.create(:timeslip, :project => project, :user => user, :date => 1.month.ago)
      @timeslips = Timeslip.where(:user_id => user)
    end

    it "should return timeslips from this week" do
      get_timeslips_with_timeframe(@timeslips, "This Week").count.should == 1
    end

    it "should return timeslips from last week" do
      get_timeslips_with_timeframe(@timeslips, "Last Week").count.should == 1
    end

    it "should return timeslips from this month" do
      get_timeslips_with_timeframe(@timeslips, "This Month").count.should == 2
    end

    it "should return timeslips from last month" do
      get_timeslips_with_timeframe(@timeslips, "Last Month").count.should == 1
    end
  end

  context :get_timeslips_with_dates do
    before :each do
      company = FactoryGirl.create(:company)
      user = FactoryGirl.create(:user, :company => company, :owns_company => true)
      project = FactoryGirl.create(:project, :company => company)
      FactoryGirl.create(:timeslip, :project => project, :user => user, :date => Date.today)
      FactoryGirl.create(:timeslip, :project => project, :user => user, :date => 1.week.ago)
      @old_timeslip = FactoryGirl.create(:timeslip, :project => project, :user => user, :date => 1.month.ago)
      @timeslips = Timeslip.where(:user_id => user)
    end

    it "should return timeslips between two dates" do
      get_timeslips_with_dates(@timeslips, 1.week.ago.strftime("%d/%m/%y"), Date.today.strftime("%d/%m/%y")).count.should == 3
    end

    it "shouldn't return timeslips outside of the two dates" do
      puts get_timeslips_with_dates(@timeslips, 1.week.ago.strftime("%d-%m-%Y"), Date.today.strftime("%d-%m-%Y")).should_not include @old_timeslip
    end
  end
end
