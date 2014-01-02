class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

  protected
    
    def authorize    
      redirect_to new_user_session_path, notice: "Please log in" if !logged_in?
    end

    def logged_in?
      !!current_user
    end

    def redirect_to_back_or_default_url(url = root_path)
      alert_message = "You are not authorized to view the requested page"
      if request.referer
        redirect_to :back, alert: alert_message
      else
        redirect_to url, alert: alert_message
      end
    end
end
