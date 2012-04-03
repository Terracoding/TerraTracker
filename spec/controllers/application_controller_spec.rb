require 'spec_helper'

describe ApplicationController do
  
  describe "user paths" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    
    controller do
      def after_sign_in_path_for(resource)
          super resource
      end
      def after_sign_up_path_for(resource)
          super resource
      end
      def after_sign_out_path_for(resource)
          super resource
      end
    end

    describe "After signing in" do
      it "redirects to the /dashboard page" do
          controller.after_sign_in_path_for(@user).should == dashboard_index_path
      end
    end

    describe "After signing up" do
      it "redirects to the /dashboard page" do
          controller.after_sign_up_path_for(@user).should == dashboard_index_path
      end
    end

    describe "After signing out" do
      it "redirects to the / page" do
          controller.after_sign_out_path_for(@user).should == root_path
      end
    end
  end

end