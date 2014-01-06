class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize
  before_action :set_current_user_thread


  protected
    
    def authorize    
      redirect_to new_user_session_path, notice: "Please log in" if !logged_in?
    end

    def logged_in?
      !!current_user
    end

    def set_current_user_thread
      Thread.current[:user] = current_user
    end

    def redirect_to_back_or_default_url(url = root_path)
    
      if request.referer
        redirect_to :back
      else
        redirect_to url
      end
    end
end
