require 'spec_helper'

describe Subscription do
  context :validations do
    it { should belong_to(:user) }
  end
end
