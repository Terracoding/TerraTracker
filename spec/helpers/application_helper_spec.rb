require 'spec_helper'

describe ApplicationHelper do
  
  describe "twitterized_type" do
    it "should return the twitterized type for alert" do
      twitterized_type(:alert).should == "alert alert-block"
    end
    
    it "should return the twitterized type for error" do
      twitterized_type(:error).should == "alert alert-error"
    end
    
    it "should return the twitterized type for notice" do
      twitterized_type(:notice).should == "alert alert-success"
    end
    
    it "should return the twitterized type for anything else as info" do
      twitterized_type("").should == "alert alert-info"
    end
  end
  
end
