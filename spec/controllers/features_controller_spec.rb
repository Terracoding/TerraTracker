require 'spec_helper'

describe FeaturesController do
  
  describe :index do
    it "loads with a 200 success" do
      get :index
      response.should be_success
      response.status.should == 200
    end
  end

end
