class Api::V1::UsersController < Api::V1::ApiController

  def login
    user = User.find_by_email(params[:email])
    if user.valid_password? params[:password]
      respond_to do |format|
        format.json { render :json => user.to_json, :status => 200 }
      end
    else
      respond_to do |format|
        format.json { render :json => "Unauthorised", :status => 401 }
      end
    end
  end

end
