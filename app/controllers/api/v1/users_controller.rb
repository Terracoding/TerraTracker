class Api::V1::UsersController < Api::V1::ApiController

  def login
    user = User.find_by_email(params[:email])
    if user.valid_password? params[:password]
      token = Token.find(:first, :conditions => { :user_id => user.id }, :readonly => false) || Token.new( :user_id => user.id, :token => SecureRandom::hex(16))
      token.update_attributes(:token => SecureRandom::hex(16)) unless token.new_record?
      token.save if token.new_record?
      respond_to do |format|
        format.json { render :json => token.to_json, :status => 200 }
      end
    else
      respond_to do |format|
        format.json { render :json => "Unauthorised", :status => 401 }
      end
    end
  end

end
