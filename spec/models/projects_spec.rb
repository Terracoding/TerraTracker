require 'spec_helper'

describe Project do

  describe "validations" do
    before(:each) do
      @company = FactoryGirl.create(:company)
    end
    subject { FactoryGirl.create(:project, :company => @company) }
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

  context :available_statuses do
    it "should return a list of available statuses" do
      p = Project.new
      p.available_statuses.should == ["Active","Completed","Cancelled"]
    end
  end

  context :check_project_creation do
    before(:each) do
      company = FactoryGirl.create(:company)
      @project = FactoryGirl.build(:project, :company => company)
    end

    it "should does not return false if less than the user limit" do
      @project.stub_chain(:company, :projects, :count).and_return(1)
      @project.stub_chain(:company, :plan, :project_count).and_return(4)
      @project.stub_chain(:company, :projects, :where, :count).and_return(0)
      @project.save.should_not be_false
    end

    it "should return false if project limit met" do
      @project.stub_chain(:company, :projects, :count).and_return(2)
      @project.stub_chain(:company, :plan, :project_count).and_return(2)
      @project.stub_chain(:company, :projects, :where, :count).and_return(0)
      @project.save.should be_false
    end

    it "should provide an error message when returning false" do
      @project.stub_chain(:company, :projects, :count).and_return(2)
      @project.stub_chain(:company, :plan, :project_count).and_return(2)
      @project.stub_chain(:company, :projects, :where, :count).and_return(0)
      @project.save
      @project.errors.full_messages.should include "You have reached your project limit. If you wish to add more projects, please upgrade your account."
    end
  end

  context :check_project_limit do
    before(:each) do
      company = FactoryGirl.create(:company)
      @project = FactoryGirl.create(:project, :company => company, :archived => true)
    end

    it "should not allow a user to unarchive a project when they are at their limit" do
      @project.stub_chain(:company, :projects, :count).and_return(1)
      @project.stub_chain(:company, :plan, :project_count).and_return(1)
      @project.stub_chain(:company, :projects, :where, :count).and_return(1)
      @project.archived = false
      @project.should_not be_valid
    end
  end
end
