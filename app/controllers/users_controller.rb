class UsersController < ApplicationController

  def show
    graph = Koala::Facebook::API.new(current_user.oauth_token)
    @friends = graph.get_connections('me', 'friends')
  end

  def show_events
    @friends = current_user.friends
    render 'events_page'
  end

  def settings
  end
end
