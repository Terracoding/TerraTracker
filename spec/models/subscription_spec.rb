#coding: utf-8
require 'spec_helper'

describe Subscription do
  context :validations do
    it { should belong_to(:company) }
  end
end
