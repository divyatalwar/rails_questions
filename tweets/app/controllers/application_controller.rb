#FIXME_AB: Remove unused files through out the project
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

    #FIXME_AB: I don't like this. This is not the way. 
    #fixed

    def redirect_to_back_or_default_url(url = root_path)
      if request.referer
        redirect_to :back
      else
        redirect_to url
      end
    end
end
