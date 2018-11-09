class UsersController < PagesController
    def profile        
        @hide_side_nav = true
        if user_signed_in?
            @current_user_email = current_user.email
            @current_user_last_update_time = current_user.updated_at
            @current_user_fitbit_configured = current_user.fitbitconfigured     
            #params.fetch(:important_and_required)              
            @token = ''
            if @current_user_fitbit_configured == true                                 
                @token = 'old_user'
                Userfitbitdetails()
            else
                @current_user_fitbit_configured = false
                #User is not configured for fitbit
                @token = params[:code]
                if @token !=''
                    Userfitbitdetails()
                end
            end
        end
        
        
    end

    protected
    
    def Userfitbitdetails
        @user = User.find_by(email:@current_user_email)
        if @token == 'old_user'
            @token = @user.fitbitkey
        else
            @user.fitbitkey = @token
            @user.fitbitconfigured = true        
            @user.save
        end       




    end
end