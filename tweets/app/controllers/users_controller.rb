class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    #FIXME_AB: Can you try this url: http://localhost:3000/users/abcdefghijklmnop and let me know what is wrong with it
  end
  
  def timeline
    #FIXME_AB: I guess, whenever we will be using timeline we need associations. So shouldn't we eager load associations within the timeline.
    @tweets = current_user.timeline.including_associations
  end

  protected

  def set_user
    @user = User.find_by(firstname: params[:id])
    redirect_to_back_or_default_url if(@user.nil?)
  end
end