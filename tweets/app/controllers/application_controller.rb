#FIXME_AB: Remove unused files through out the project
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :store_location
  before_action :authorize

  before_action :set_current_user_thread
  
  protected



  def store_location
    if (request.fullpath != "/user/sign_in" &&
      request.fullpath != "/user/sign_up" &&
      request.fullpath != "/user/sign_out" &&
      !request.post? && !request.xhr?)
      session[:previous_url] = request.fullpath 
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_up_path_for(resource)
    session[:previous_url] || root_path
  end
    
    def authorize    
      redirect_to new_user_session_path, notice: "Please log in" if !logged_in?
    end

    def logged_in?
      !!current_user
    end

    #FIXME_AB: I don't like this. This is not the way. 
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
