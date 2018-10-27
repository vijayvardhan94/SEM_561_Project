class ApplicationController < ActionController::Base
    
    
    before_action :set_cache_headers
    before_action :authenticate_user!,except:[:index,:about] 

    protect_from_forgery

  private

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
