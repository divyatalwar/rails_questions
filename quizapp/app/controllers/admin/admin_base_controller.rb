class Admin::AdminBaseController < ApplicationController

  before_action :authorize_as_admin

  def authorize_as_admin
    if ! current_user.admin?
      redirect_to "/", flash: { alert: "You are not authorized to view the requested page" }
    end
  end

end