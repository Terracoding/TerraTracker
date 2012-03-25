require 'spec_helper'

describe ProjectUser do
  context :validations do
    it { should belong_to(:project) }
    it { should belong_to(:user) }
  end
end
