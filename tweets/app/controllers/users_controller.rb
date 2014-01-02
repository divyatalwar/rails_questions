class UsersController < ApplicationController


  before_filter :set_user, only: [:show, :followees, :followers]

  def show
  
  end


  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User #{@user.firstname} was successfully updated." }
      else
        format.html { render action: 'edit', error: "Profile not updated" }
      end

    end
  end

  def destroy
 
    if(@user.destroy)
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'User destroyed' }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, error: 'User not destroyed' }
      end
    end
  end

  def home
    users = current_user.followees + [current_user]
    @posts = Post.by_users(users)
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