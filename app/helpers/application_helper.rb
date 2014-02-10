module ApplicationHelper
 
  def date_parser(date_string)
    begin
      Date.strptime(date_string, "%m/%d/%Y")
    rescue
      begin
        Date.strptime(date_string, "%m/%d")
      rescue
        date_string.to_s
      end
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def connect_to_facebook
    Koala::Facebook::API.new(current_user.oauth_token)
  end

  def set_app_time_zone
    Time.zone = current_user.time_zone if current_user
  end
end
