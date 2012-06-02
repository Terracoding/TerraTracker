class Api::V1::ApiController < ApplicationController

  before_filter :validate_api_key

  private

  def validate_api_key
    authenticate_or_request_with_http_token do |token, options|
      DeveloperApplication.exists?(api_key: token)
    end
  end

end
