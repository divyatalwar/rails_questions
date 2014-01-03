class UsersController < ApplicationController


  before_action :set_user, only: [:show]

  def show
  
  end

  
  def timeline
    users = current_user.followees + [current_user]
    @posts = UserPost.by_users(users)
  end

  protected

  def set_user
    @user = User.find_by(firstname: params[:id])
    redirect_to_back_or_default_url if(@user.nil?)
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname)
  end


end