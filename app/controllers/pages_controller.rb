class PagesController < ApplicationController
  def about
    @hide_side_nav = true
  end

  def index
    @hide_side_nav = true
  end

  def login
    @hide_side_nav = true
    @hide_side_nav = true
        if user_signed_in?
            @current_user_email = current_user.email
            @current_user_last_update_time = current_user.updated_at
            @current_user_fitbit_configured = current_user.fitbitconfigured     
        end     
  end

  def dashboard  
    if user_signed_in? && current_user.fitbitconfigured ==true                         
      @current_user_fitbit_configured = current_user.fitbitconfigured            
      userDatum = UserDatum.find_by(emailid:current_user.email)
      if userDatum == nil
        Dashing.send_event('fitbit', { error: {"message":"Fitbit is not Synced/Added"} })
        #flash[:notice] = "Dashboard Data Generation Failed"
      else        
        #flash[:notice] = "Dashboard Created Successfully"
        Dashing.send_event('fitbit',userDatum.content)
      end       
    end
  end
 
end
