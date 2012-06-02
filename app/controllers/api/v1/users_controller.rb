class Api::V1::UsersController < Api::V1::ApiController

  def login
    respond_to do |format|
      format.json { render :json => { :hello => :world }.to_json }
    end
  end

end
