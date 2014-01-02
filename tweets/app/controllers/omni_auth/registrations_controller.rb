class OmniAuth::RegistrationsController < Devise::RegistrationsController
  skip_before_action :authorize
  before_filter :configure_permitted_parameters
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password,:firstname, :lastname, :confirm_passwords) }
  end


end