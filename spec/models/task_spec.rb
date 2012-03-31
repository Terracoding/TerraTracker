require 'spec_helper'

describe Task do
  context :validations do
    it { should belong_to(:project) }
    it { should have_many(:timeslips) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:project) }
  end
end
