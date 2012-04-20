require 'spec_helper'

describe BillsController do

  context :index do
    before(:each) do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      sign_in @user
    end

    it "should load the index view" do
      post :index
      response.should be_success
      sign_out @user
    end
  end

  context :new do
    before(:each) do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      sign_in @user
    end

    it "should create a new task" do
      post :new
      response.should be_success
      sign_out @user
    end
  end

  context :create do
     before(:each) do
       @company = FactoryGirl.create(:company)
       @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
       sign_in @user
     end

     it "should create a new bill with a user" do
       bill = FactoryGirl.build(:bill, :company => @company, :user => @user)
       bill.user.should == @user
       sign_out @user
     end
     
     it "should create a new bill with a company" do
       bill = FactoryGirl.build(:bill, :company => @company, :user => @user)
       bill.company.should == @company
       sign_out @user
     end

     it "should redirect when saving the new bill" do
       bill = FactoryGirl.build(:bill, :company => @company, :user => @user)
       Bill.stub(:new) { bill }
       post :create
       response.should redirect_to(bills_path)
       sign_out @user
     end

     it "should render new when not saving the new task" do
       bill = mock_model(Bill, :save => false)
       Bill.stub(:build).and_return(bill)
       bill.stub(:save).and_return(false)
       post :create
       response.should render_template("new")
       sign_out @user
     end
   end
end
