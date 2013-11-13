class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_app_time_zone
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def set_app_time_zone
    Time.zone = current_user.time_zone if current_user
  end
end
