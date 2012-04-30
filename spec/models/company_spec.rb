require 'spec_helper'

describe Company do
  context :validations do
    it { should belong_to(:plan) }
    it { should have_one(:subscription) }
    it { should have_many(:users) }
    it { should have_many(:projects) }
    it { should have_many(:tasks).through(:projects) }
    it { should have_many(:timeslips).through(:projects) }
  end

  context :tasks_count do
    it "should show 0 for no tasks" do
      company = FactoryGirl.create(:company)
      company.tasks_count.should == 0
    end
    it "should show tasks count" do
      company = FactoryGirl.create(:company)
      user = FactoryGirl.create(:user, :company => company, :owns_company => true)
      project = FactoryGirl.create(:project, :company => company)
      task = FactoryGirl.create(:task, :project_id => project.id)
      company.tasks_count.should == 1
    end
  end

end
