class FollowingsController < ApplicationController
  before_action :set_following, only: [:show, :edit, :update, :destroy]

  def create
    @following = current_user.followings.build(following_params)

    if @following.save
          flash[:notice] = "You are now following" + @following.followee.firstname 
          redirect_to_back_or_default_url 
  
      else
        redirect_to current_user 
      end
 
  end


  def destroy
    if(@following.destroy)
      flash[:notice] = "You are not following " +  @following.followee.firstname 
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