require 'spec_helper'

describe ProjectUser do
  context :validations do
    subject { ProjectUser.create!(:project_id => 1, :user_id => 1) }
    it { should belong_to(:project) }
    it { should belong_to(:user) }
    it { should validate_presence_of(:project_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:project_id) }
  end
end
