require 'spec_helper'

describe Company do
  context :validations do
    it { should have_many(:users) }
    it { should have_many(:projects) }
  end

  context :tasks_count do
    it "should show 0 for no tasks" do
      company = Factory.create(:company)
      company.tasks_count.should == 0
    end
    it "should show tasks count" do
      company = Factory.create(:company)
      user = Factory.create(:user, :company => company, :owns_company => true)
      project = Factory.create(:project, :company => company)
      task = Factory.create(:task, :project_id => project.id)
      company.tasks_count.should == 1
    end
  end

end
