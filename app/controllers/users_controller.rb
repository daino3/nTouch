class UsersController < ApplicationController

  def show
    @graph = Koala::Facebook::API.new(current_user.oauth_token)
    @friends = @graph.get_connections('me', 'friends')
  end

  def search
    selected_friend = params[:facebookUser]
    @graph      = Koala::Facebook::API.new(current_user.oauth_token)
    @friend     = @graph.get_object(selected_friend)
    @photo      = @graph.get_picture(selected_friend, type: 'large')
  end

  def show_events
    @friends = current_user.friends
    render 'events_page'
  end

end
