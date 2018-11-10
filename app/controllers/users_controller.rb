class UsersController < PagesController
    def profile        
        @hide_side_nav = true
        if user_signed_in?
            @current_user_email = current_user.email
            @current_user_last_update_time = current_user.updated_at
            @current_user_fitbit_configured = current_user.fitbitconfigured 
            @current_user_fitbitkey = current_user.fitbitkey   
            #params.fetch(:important_and_required)              
            @token = 'dummy'             
            if @current_user_fitbit_configured == true
                GetUserfitbitdetails()
                puts  @token
             
            #if @current_user_fitbit_configured == false               
            else
                #User is not configured for fitbit
                @token = params[:code]
                if @token != nil || @token != '' || @token != 'dummy'
                    AddUserfitbitdetails()
                end
            end            
        end
    end

    protected
    
    def AddUserfitbitdetails
        user = User.find_by(email:@current_user_email)        
        #@user.fitbitconfigured = true
        user.fitbitkey = @token        
        if user.fitbitkey == nil
            user.fitbitconfigured = true
        else
            user.fitbitconfigured = true
        end
        user.save
        #@fitbitkey = user.fitbitkey
    end       
    
    def GetUserfitbitdetails
        user = User.find_by(email:@current_user_email)
        token = user.fitbitkey
        if token == nil
            @current_user_fitbitkey = params[:code]
            user.fitbitkey = @current_user_fitbitkey
            user.save
            #@token = params[:code]
        else    
        @current_user_fitbitkey = token
        end
    end

    def user
    
    end

end