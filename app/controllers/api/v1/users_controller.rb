class Api::V1::UsersController < ApplicationController
  before_filter {validate_api_key(params[:api_key], params[:secret_key], params[:account_id])}
  
  def login
    respond_to do |format|
      format.json { render :json => { :hello => "hello", :world => "world"}.to_json }
    end
  end

end