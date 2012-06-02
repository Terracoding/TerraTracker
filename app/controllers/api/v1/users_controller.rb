class Api::V1::UsersController < ApplicationController

  before_filter :validate_api_key

  def login
    respond_to do |format|
      format.json { render :json => { :hello => "hello", :world => "world"}.to_json }
    end
  end

  private

  def validate_api_key
    p params
    p DeveloperApplication.exists?(api_key: params[:authorization])
    authenticate_or_request_with_http_token do |token, options|
      DeveloperApplication.exists?(api_key: token)
    end
  end

end
