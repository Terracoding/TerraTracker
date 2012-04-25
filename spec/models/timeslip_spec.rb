require 'spec_helper'

describe Timeslip do
  it { should belong_to(:task) }
  it { should belong_to(:user) }
  it { should belong_to(:project) }
  it { should validate_presence_of(:task) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:project) }
  it { should validate_presence_of(:date) }

  describe "handling hours" do
    before(:each) do
      @task = FactoryGirl.create :task
      @user = FactoryGirl.create :user
      @project = FactoryGirl.create :project
      @timeslip = Timeslip.new(task: @task, user: @user, project: @project)
    end

    it "handles mass assignment" do
      @timeslip = Timeslip.new({:task => @task, :user => @user, :project => @project, :hours => "5:30"})
      @timeslip.hours.should == BigDecimal("5.5")
    end

    it "converts hours and minutes to a decimal" do
      @timeslip.hours = "5:30"
      @timeslip.hours.should == BigDecimal("5.5")
    end

    it "keeps whole hours as is" do
      @timeslip.hours = "5"
      @timeslip.hours.should == BigDecimal("5")
    end

    it "keeps decimals as is" do
      @timeslip.hours = "5.5"
      @timeslip.hours.should == BigDecimal("5.5")
    end

    it "treats input as lazy (0:5 = 50 minutes)" do
      @timeslip.hours = "0:5"
      @timeslip.hours.should == BigDecimal((5.to_f/6).to_s)
    end

    it "works correctly with verbose time format input (0:05 = 5 minutes)" do
      @timeslip.hours = "0:05"
      @timeslip.hours.should == BigDecimal((5.to_f/60).to_s)
    end
  end
end
