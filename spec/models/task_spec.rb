require 'spec_helper'

describe Task do
  context :validations do
    it { should belong_to(:project) }
  end
end
