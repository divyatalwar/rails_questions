class Admin::UsersController < Admin::AdminBaseController
  def index
    @users = User.except(current_user)
  end
end
