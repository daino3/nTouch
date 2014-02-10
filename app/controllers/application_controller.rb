class ApplicationController < ActionController::Base

  include ApplicationHelper
  
  protect_from_forgery with: :exception
  before_filter :set_app_time_zone
  helper_method :current_user


end
