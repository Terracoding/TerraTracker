require 'spec_helper'

describe ApplicationController do
  
  describe "user paths" do
    before(:each) do
      @user = Factory.create(:user)
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
  
  # context :redirect_projects do
  #   before(:each) do
  #     @user = Factory.create(:user, :email => 'company@example.com')
  #     @company = Factory.create(:company)
  #     @user = Factory.create(:user, :company => @company, :owns_company => true)
  #     sign_in @user
  #     controller.stub(:current_company).and_return(@company)
  #     # controller.send(:redirect_projects)
  #   end
  # 
  #   it "should redirect if the project count is less than 1" do
  #     controller.send(:redirect_projects)
  #     response.should redirect_to(new_project_path)
  #   end
  # end

end