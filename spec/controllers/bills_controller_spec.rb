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

  context :edit do
    before(:each) do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      @bill = FactoryGirl.create(:bill, :company => @company, :user => @user)
      sign_in @user
    end

    it "should edit the bill" do
      post :edit, :id => @bill.id
      response.should be_success
      sign_out @user
    end
  end

  context :show do
    before (:each) do
      @company = FactoryGirl.create(:company)
      @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
      @bill = FactoryGirl.create(:bill, :company => @company, :user => @user)
      sign_in @user
    end

    it "should be able to show the bill" do
      post :show, :id => @bill.id
      response.should render_template("show")
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

   context :update do
     before(:each) do
       @company = FactoryGirl.create(:company)
       @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
       @bill = FactoryGirl.create(:bill, :company => @company, :user => @user, :due_date => DateTime.now, :bill_date => DateTime.now, :reference_id => "01", :value => 20)
       sign_in @user
     end

     it "should redirect to bills path after updating" do
       put :update, :id => @bill.id
       flash[:notice].should == "The bill was successfully updated."
       response.should redirect_to(bills_path)
       sign_out @user
     end

     it "should render edit template if not updated attributes" do
       Bill.should_receive(:find).and_return(@bill)
       @bill.stub(:update_attributes).and_return(false)
       put :update, :id => @bill.id
       response.should render_template(:edit)
       sign_out @user
     end
   end

   context :destroy do
     before(:each) do
       @company = FactoryGirl.create(:company)
       @user = FactoryGirl.create(:user, :company => @company, :owns_company => true)
       @bill = FactoryGirl.create(:bill, :company => @company, :user => @user)
       sign_in @user
       delete :destroy, :id => @bill.id
     end

     it "should redirect to the bills path" do
       response.should redirect_to(bills_path)
       sign_out @user
     end

     it "should show a flash notice" do
       flash[:notice].should == "The bill was successfully removed."
       sign_out @user
     end
   end
end
