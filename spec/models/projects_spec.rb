require 'spec_helper'

describe Project do

  describe "validations" do
    it { should belong_to(:company) }
    it { should validate_presence_of(:name) }
    it { should have_many(:tasks) }
  end
  
  context :to_s do
    it "should return the project name" do
      company = Factory.create(:company)
      project = Factory.create(:project, :company => company)
      project.to_s.should == project.name
    end
  end

end
