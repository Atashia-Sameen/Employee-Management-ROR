class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :role, :organization_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role])
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized."
    redirect_to(request.referrer || root_path)
  end
end
