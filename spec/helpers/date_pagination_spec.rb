require 'spec_helper'

describe DatePagination do

  context :get_dates do
    before :each do
      @dates = get_dates(Date.today)
    end

    it "should return 7 days" do
      @dates.count.should == 7
    end

    it "should include the inputted date" do
      @dates.should include Date.today.strftime("%A %e %b %Y")
    end

    it "should include the start of the week (Monday)" do
      start_date = Date.today - Date.today.cwday + 1
      @dates.should include start_date.strftime("%A %e %b %Y")
    end

    it "should include the end of the week (Sunday)" do
      end_date = Date.today + (7 - Date.today.cwday)
      @dates.should include end_date.strftime("%A %e %b %Y")
    end
  end

  context :get_start_date do
    it "should get the date for the beginning of the week" do
      start_date = Date.today - Date.today.cwday + 1
      get_start_date(Date.today).should == start_date
    end
  end

  context :get_end_date do
    it "should get the date for the end of the week" do
      end_date = Date.today + (7 - Date.today.cwday)
      get_end_date(Date.today).should == end_date
    end
  end

  context :find_current_week do
    before :each do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      @project = FactoryGirl.create(:project, :company => @company)
      @timeslip = FactoryGirl.create(:timeslip, :project => @project, :user => @user, :date => Date.today)
      @timeslips = Timeslip.where(:user_id => @user)
    end

    describe "week view" do
      it "should return 7 dates for the default options" do
        date_paginate(@timeslips).count.should == 7
      end

      it "should return 7 dates if the week has no timeslips" do
        date_paginate(@timeslips, { :date => Date.today - 30 }).count.should == 7
      end

      it "should return 1 date if include empty is false" do
        date_paginate(@timeslips, { :include_empty => false }).count.should == 1
      end

      it "should contain the timeslip in the correct date hash" do
        dates = date_paginate(@timeslips)
        date_string = @timeslip.date.strftime("%A %e %b %Y")
        dates[date_string].first.should == @timeslip
      end

      it "shouldn't contain the timeslip in another date hash" do
        dates = date_paginate(@timeslips)
        date_string = Date.yesterday.strftime("%A %e %b %Y")
        dates[date_string].count.should == 0
      end

      it "should include the timeslip when it's in the current week" do
        dates = date_paginate(@timeslips, { :date => Date.yesterday })
        date_string = Date.today.strftime("%A %e %b %Y")
        dates[date_string].count.should == 1
      end
    end

    describe "day view" do
      it "should return 1 date" do
        date_paginate(@timeslips, { :view => "day" }).count.should == 1
      end

      it "should return 1 date if the day has no timeslips" do
        date_paginate(@timeslips, { :view => "day", :date => Date.yesterday }).count.should == 1
      end

      it "shouuld return nothing if both the date and include empty are false" do
        date_paginate(@timeslips, { :view => "day", :include_empty => false, :date => Date.yesterday }).count.should == 0
      end
    end
  end

end
