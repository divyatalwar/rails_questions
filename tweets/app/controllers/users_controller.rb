class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :create_post, only:[ :show]

  def index
    @users = User.except(current_user)
  end

  def show
    #FIXME_AB: Can you try this url: http://localhost:3000/users/abcdefghijklmnop and let me know what is wrong with it
  
  end

  def autocomplete_suggestions
    render :json => User.get_autocomplete_suggestions
  end
  
  def timeline
    #FIXME_AB: I guess, whenever we will be using timeline we need associations. So shouldn't we eager load associations within the timeline.
    #fixed
    @tweets = current_user.timeline
  end

  def change_privacy
    current_user.update_privacy
    redirect_to_back_or_default_url
  end




  protected

  def create_post
    @post = Post.new
  end

  def set_user
    @user = User.find_by(username: params[:id])
    if(@user.nil?)
      flash[:alert] = "user by this name does not exist"
      redirect_to_back_or_default_url
    end  
  end
end