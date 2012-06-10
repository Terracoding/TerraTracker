require 'spec_helper'

describe Token do
  describe :validations do
    it { should belong_to(:user) }
  end
end
