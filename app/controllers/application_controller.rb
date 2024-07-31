class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # rescue_from ActiveRecord::RecordNotFound, with: :render_404
  # rescue_from StandardError, with: :render_500

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :role, :organization_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role])
  end

end
