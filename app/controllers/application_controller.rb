class ApplicationController < ActionController::Base
    helper_method :current_user
    
    def current_user
        if session[:user_id]
            @current_user ||=User.find(session[:user_id])
        else
            @current_user = nil
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
end
