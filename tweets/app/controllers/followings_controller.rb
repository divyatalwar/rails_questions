class FollowingsController < ApplicationController
  before_action :set_following, only: [:destroy]

  def create
    #FIXME_AB: There is no way I can follow any user. Because I don't have a list of users where I can follow them. 
    @following = current_user.followings.build(following_params)
    if @following.save
      flash[:notice] = "You are now following " + @following.followee.name 
      redirect_to_back_or_default_url 
    else
      redirect_to current_user , alert:  "Some error happened.Please try again" 
    end

  end


  def destroy
    if(@following.destroy)
      flash[:notice] = "You are now not following " +  @following.followee.name 
    end
    redirect_to_back_or_default_url 
  end

  protected

    def set_following
      @following = current_user.followings.find_by(followee_id: params[:followee_id])
      redirect_to_back_or_default_url if @following.nil? 
    end

    def following_params
      params.permit(:followee_id)
    end
end