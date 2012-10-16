class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActionController::RoutingError, :with => :routing_error
  rescue_from ActiveRecord::RecordNotFound, :with => :routing_error # self defined exception
  
  before_filter :set_cache_buster
  
  def admin_required  
    unless current_user && (current_user.admin == true || current_user.id == 1)  
      redirect_to '/'  
    end
  end
  
  def admin_or_owner_required(id)  
    unless current_user.id == id || current_user.admin == true || current_user.id == 1  
      redirect_to '/'  
    end
  end
  
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
   
  protected

    def routing_error(exception)
      puts exception;
      redirect_to '/' , notice: 'The page you requested does not exist... 
      Did you just try to play with the URL....'
    end 
end
