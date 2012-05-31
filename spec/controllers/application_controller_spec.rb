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

  describe :validate_api_key do
    it "should return true if the keys and the user are valid" do
      user = FactoryGirl.create(:user)
      dev_app = FactoryGirl.create(:developer_application, :user => user)
      controller.validate_api_key(dev_app.api_key, dev_app.secret_key, dev_app.user).should == true
    end

    it "should return false if the user is incorrect" do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user, :email => "second_email@example.com")
      dev_app = FactoryGirl.create(:developer_application, :user => user)
      controller.validate_api_key(dev_app.api_key, dev_app.secret_key, user2).should == false
    end

    it "should return false if the user is nil" do
      user = FactoryGirl.create(:user)
      dev_app = FactoryGirl.create(:developer_application, :user => user)
      controller.validate_api_key(dev_app.api_key, dev_app.secret_key, nil).should == false
    end

    it "should return false if the api key is incorrect" do
      user = FactoryGirl.create(:user)
      dev_app = FactoryGirl.create(:developer_application, :user => user)
      controller.validate_api_key("78234q78fy3847ytq", dev_app.secret_key, dev_app.user).should == false
    end

    it "should return false if the api key is nil" do
      user = FactoryGirl.create(:user)
      dev_app = FactoryGirl.create(:developer_application, :user => user)
      controller.validate_api_key(nil, dev_app.secret_key, dev_app.user).should == false
    end

    it "should return false if the secret key is incorrect" do
      user = FactoryGirl.create(:user)
      dev_app = FactoryGirl.create(:developer_application, :user => user)
      controller.validate_api_key(dev_app.api_key, "wefwaef23f2q43f", dev_app.user).should == false
    end

    it "should return false if the secret key is nil" do
      user = FactoryGirl.create(:user)
      dev_app = FactoryGirl.create(:developer_application, :user => user)
      controller.validate_api_key(dev_app.api_key, nil, dev_app.user).should == false
    end
  end

end