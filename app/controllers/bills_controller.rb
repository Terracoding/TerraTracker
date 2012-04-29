class BillsController < ApplicationController
  before_filter :authenticate_user!, :redirect_sub_account, :redirect_company

  def index
    @bills = Bill.where(:company_id => current_company)
  end

  def new
    @bill = Bill.new(:bill_date => Date.today, :due_date => Date.today)
  end

  def edit
    @bill = Bill.find(params[:id])
  end

  def show
    @bill = Bill.find(params[:id])
  end

  def create
    @bill = Bill.new(params[:bill])
    @bill.user = current_user
    @bill.company = current_company
    if @bill.save
      redirect_to(bills_path, :notice => "The bill was successfully created.")
    else
      render :action => :new
    end
  end

  def update
    @bill = Bill.find(params[:id])
    if @bill.update_attributes(params[:bill])
      redirect_to(bills_path, :notice => "The bill was successfully updated.")
    else
      render :action => "edit"
    end
  end

  def destroy
    @bill = Bill.find(params[:id])
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to(bills_path, :notice => "The bill was successfully removed.") }
      format.js
    end
  end

end
