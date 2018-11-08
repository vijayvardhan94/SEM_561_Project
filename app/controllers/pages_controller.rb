class PagesController < ApplicationController
  def about
    @hide_side_nav = true
  end

  def index
    @hide_side_nav = true
  end

  def login
    @hide_side_nav = true
  end

  def dashboard
  end
  
  def profile
    @hide_side_nav = true
    if user_signed_in?
      @current_user_email = current_user.email
      @current_user_last_update_time = current_user.updated_at
      @current_user_fitbit_configured = current_user.fitbitconfigured      
    end

  end 
end
