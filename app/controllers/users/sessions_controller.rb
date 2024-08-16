class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def new
    super
  end

  def create
    super
  end

  def destroy
    sign_out current_user
    redirect_to user_session_path, notice: 'Successfully signed out.'
  end

  def after_sign_in_path_for(resource)
    employee_attendances_path(current_user.id)
  end

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
