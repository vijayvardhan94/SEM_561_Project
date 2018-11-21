class UsersController < PagesController
    
    def user
        #flash[:notice] = "Fitbit is not configured for this account"
        #Add Details down this sprint
    end

    def profile        
        @hide_side_nav = true
        if user_signed_in?
            @current_user_email = current_user.email
            @current_user_last_update_time = current_user.updated_at
            @current_user_fitbit_configured = current_user.fitbitconfigured 
            @current_user_fitbitkey = current_user.fitbitkey                             
            @token = 'dummy'             
            if @current_user_fitbit_configured == true
                GetUserfitbitdetails()
                puts  @token
            else                
                @token = params[:code]
                if @token != nil || @token != '' || @token != 'dummy'                    
                    AddUserfitbitdetails()
                end
            end            
        end
    end

    
    def sync
        if user_signed_in? && current_user.fitbitkey != nil
            @user_invalid_token = false
        else
            @user_invalid_token = true
        end           

    end
    
    def sync_new   
        if user_signed_in? && current_user.fitbitkey != nil
            unit_system   = "METRIC"
            date_format   = "%H:%M"
            animate_views = true
            @user_token = current_user.fitbitkey            
            userDatum = UserDatum.find_by(emailid:current_user.email)
            @syncTime = nil            
            user_profile = params[:profile]
            user_activity  = params[:activity]            
            user_heartrate = params[:heartrate]
            
            if userDatum == nil && user_profile != nil && user_activity != nil && user_heartrate != nil
                fitbit = Fitbit.new token: @user_token, unit_system: unit_system, date_format: date_format
                userDatum = UserDatum.create(index:current_user.id,emailid:current_user.email,content:{
                    device:    fitbit.device,
                    steps:     fitbit.steps,
                    calories:  fitbit.calories,
                    distance:  fitbit.distance,
                    active:    fitbit.active,
                    animate:   animate_views,
                    profile:   JSON.parse(user_profile),
                    activity:  JSON.parse(user_activity),
                    heartrate: JSON.parse(user_heartrate)                    
                },created_at:current_user.created_at,updated_at:DateTime.now)        
                userDatum.save
                @syncTime = userDatum.updated_at
                flash[:notice] = "Fitbit successfully synced"
            else
                if user_profile != nil && user_activity != nil && user_heartrate != nil
                    fitbit = Fitbit.new token: @user_token, unit_system: unit_system, date_format: date_format
                    userDatum.content = {
                        device:    fitbit.device,
                        steps:     fitbit.steps,
                        calories:  fitbit.calories,
                        distance:  fitbit.distance,
                        active:    fitbit.active,
                        animate:   animate_views,
                        profile:   JSON.parse(user_profile),
                        activity:  JSON.parse(user_activity),
                        heartrate: JSON.parse(user_heartrate)
                    }
                    userDatum.updated_at = DateTime.now                
                    userDatum.save
                    @syncTime = userDatum.updated_at
                    flash[:notice] = "Fitbit successfully synced"                
                else
                    flash[:notice] = "Fitbit not synced blank fitbit details"
                end
            end
        else            
            flash[:notice] = "Fitbit is not configured for this account"        
        end
    end
    
    protected
    
    def AddUserfitbitdetails
        user = User.find_by(email:@current_user_email)
        user.fitbitkey = @token        
        if user.fitbitkey == nil
            user.fitbitconfigured = false
        else
            user.fitbitconfigured = true
        end
        user.save
        #redirect_to '/users'       
    end       
    
    def GetUserfitbitdetails
        user = User.find_by(email:@current_user_email)
        token = user.fitbitkey
        if token == nil
            @current_user_fitbitkey = params[:code]
            user.fitbitkey = @current_user_fitbitkey
            user.save            
        else    
        @current_user_fitbitkey = token
        end
    end

    
end