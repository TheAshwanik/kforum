class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from ActionController::RoutingError, :with => :server_error
  #rescue_from ActiveRecord::RecordNotFound, :with => :routing_error # self defined exception
  #rescue_from Exception, :with => :rescue_all_exceptions if RAILS_ENV == 'production'
  
  rescue_from Exception, :with => :server_error

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
   
    def routing_error
      raise ActionController::RoutingError.new(params[:path])
    end
    
   def server_error(exception)
    ExceptionNotifier::Notifier.exception_notification(request.env, exception).deliver
    redirect_to '/' , notice: 'We are Sorry! Something went wrong, The page you requested does not exist..
      Or Did you just try to play with the URL....?'
   end
   

   def rescue_all_exceptions(exception)
      case exception
        when ActiveRecord::RecordNotFound
          render :text => "The requested resource was not found", :status => :not_found
        when ActionController::RoutingError, ActionController::UnknownController, ActionController::UnknownAction
          render :text => "Invalid request", :status => :not_found
        else
          EXCEPTION_LOGGER.error( "\nWhile processing a #{request.method} request on #{request.path}\n
          parameters: #{request.parameters.inspect}\n
          #{exception.message}\n#{exception.clean_backtrace.join( "\n" )}\n\n" )
          render :text => "An internal error occurred. Sorry for inconvenience", :status => :internal_server_error
      end
    end
  
end
