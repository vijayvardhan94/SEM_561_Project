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

  def analytics(data)
    # puts(data)
    steps=data['activity']['activities-steps']
    date_current=Date.current
    time_current=Time.current
    past_date= Date.current.beginning_of_month
    filter_data=steps.select { |o| Date.parse(o["dateTime"]).between?(past_date, date_current) }
    steps_plot_array=Array.new
    filter_data.each do |d|
      steps_plot_array.push d['value'].to_i
    end
    mean_steps=6000
    steps_daru = Daru::Vector.new steps_plot_array,name: :steps_values
    current_mean=steps_daru.mean
    steps_efficiency= ( current_mean/mean_steps )*100

    if steps_efficiency>90
      comment = "Good job"
    else
      comment = "Walk more"
    end
    # puts(current_mean,steps_efficiency,comment)
    sleep_d=data['sleep']['summary']
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
