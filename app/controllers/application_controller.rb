class ApplicationController < ActionController::Base
    include ExceptionHandler
    require 'json_web_token'
    helper_method :current_user
    
    def current_user

        if session[:user_id]
            @current_user ||=User.find(session[:user_id])
        elsif Authorization.new(request).current_user != nil
            @current_user = User.find(Authorization.new(request).current_user)
        else
            @current_user = nil
        end
    end

    def api_auth
        puts "request my plants api"
          authorization_object = Authorization.new(request)
          puts "current user " + authorization_object.current_user.to_s + " id"
          if authorization_object.current_user == nil
            render json: {
                message: "Incorrect username/password combination"}, status: :unauthorized
          else 
          @current_user = authorization_object.current_user
        end
    end

    def authenticate_user()
        if current_user == nil
            redirect_to root_url
        end

    end

    def set_user()
        current_user
    end
    
    def authenticate_user_admin()
        if current_user == nil || current_user.admin != true
            redirect_to root_url
        end 
    end

    protected
  # Validates the token and user and sets the @current_user scope
  def authenticate_request!
    if !payload || !JsonWebToken.valid_payload(payload.first)
      return invalid_authentication
    end

    load_current_user!
    invalid_authentication unless @current_user
  end

  # Returns 401 response. To handle malformed / invalid requests.
  def invalid_authentication
    render json: {error: 'Invalid Request'}, status: :unauthorized
  end

  private
  # Deconstructs the Authorization header and decodes the JWT token.
  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last
    JsonWebToken.decode(token)
  rescue
    nil
  end

  # Sets the @current_user with the user_id from payload
  def load_current_user!
    @current_user = User.find_by(id: payload[0]['user_id'])
  end
end
