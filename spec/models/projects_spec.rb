require 'spec_helper'

describe Project do

  describe "validations" do
    it { should belong_to(:company) }
    it { should validate_presence_of(:name) }
    it { should have_many(:tasks).dependent(:destroy) }
    it { should have_many(:project_users).dependent(:destroy) }
    it { should have_many(:users).through(:project_users) }
  end

  context :to_s do
    it "should return the project name" do
      company = FactoryGirl.create(:company)
      project = FactoryGirl.create(:project, :company => company)
      project.to_s.should == project.name
    end
  end

end
