class UsersController < ApplicationController

  def show
    @graph = Koala::Facebook::API.new(current_user.oauth_token) # why is this an instance variable?
    @friends = @graph.get_connections('me', 'friends')
  end

  def show_events
    @friends = current_user.friends
    render 'events_page'
  end

  def settings
  end
  # stop leaving random new lines before closing end statements
end
