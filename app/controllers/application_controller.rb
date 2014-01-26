class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def authorize_user_is_employee
    deny_access unless current_user.is_employee?
  end

  def authorize_user_is_admin
    if current_user
      deny_access unless current_user.is_admin?
    else
      deny_access
    end
  end

  def authorize_user_is_not_employee
    deny_access if current_user.is_employee?
  end

  def deny_access
    redirect_to root_path, notice: 'You do not have permission to access that page'
  end

  def current_user_is_page_user
    deny_access if current_user.id.to_s != params[:user_id]
  end

  def current_user_is_order_holder
    if !current_user.is_employee?
      deny_access if current_user.id.to_s != params[:user_id]
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name]
  end
end
