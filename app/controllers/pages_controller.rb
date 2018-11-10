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
    
      unit_system   = "METRIC"
      date_format   = "%H:%M"
      animate_views = true
      user_token = current_user.fitbitkey
      fitbit = Fitbit.new token: user_token, unit_system: unit_system, date_format: date_format
      #fitbit = Fitbit.new unit_system: unit_system, date_format: date_format       
      if fitbit.errors?
        Dashing.send_event('fitbit', { error: fitbit.error })
      else
        Dashing.send_event('fitbit', {
        device:   fitbit.device,
        steps:    fitbit.steps,
        calories: fitbit.calories,
        distance: fitbit.distance,
        active:   fitbit.active,
        animate:  animate_views
       })
      end
    end
  end
 
end
