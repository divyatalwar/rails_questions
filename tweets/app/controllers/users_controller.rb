class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
  end
  
  def timeline
    @tweets = current_user.timeline
  end

  protected

  def set_user
    @user = User.find_by(firstname: params[:id])
    redirect_to_back_or_default_url if(@user.nil?)
  end
end