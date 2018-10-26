class ApplicationController < ActionController::Base
    before_action :authenticate_user!,except:[:index,:about] 
    protect_from_forgery




end