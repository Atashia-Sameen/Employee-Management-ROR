class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :verify_user_id

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :role, :organization_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role])
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized."
    redirect_to( request.referrer || employee_attendances_url(current_user) )
  end

  def verify_user_id
    return unless params[:employee_id].present?
    if params[:employee_id].to_i != current_user.id
      redirect_to employee_leaves_path(current_user), alert: "You are not authorized to view this page."
    end
  end
  

end
