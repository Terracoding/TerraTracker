require 'spec_helper'

describe Timeslip do
  it { should belong_to(:task) }
  it { should belong_to(:user) }
  it { should belong_to(:project) }
  it { should validate_presence_of(:task) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:project) }
end
