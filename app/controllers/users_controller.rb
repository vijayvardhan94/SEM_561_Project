class UsersController < PagesController
    def profile        
        @hide_side_nav = true
        if user_signed_in?
            @current_user_email = current_user.email
            @current_user_last_update_time = current_user.updated_at
            @current_user_fitbit_configured = current_user.fitbitconfigured      
        end        
    end 
    
    def sign_out
        
    end
end