  class UsersController < ApplicationController

  def show
  end

  def interaction_data
    friend_uid = params[:data]
    graph = Koala::Facebook::API.new(current_user.oauth_token)    
    posts_from_friend = Friend.facebook_friend_to_me(graph, friend_uid)
    posts_from_me     = Friend.facebook_me_to_friend(graph, friend_uid)
    @graph_data = {friend_uid: friend_uid, friend: posts_from_friend, me: posts_from_me}
    render partial: "interaction_graph"
  end

  def show_events
    @user = current_user
    @friends = current_user.friends
    @email = current_user.email
    @phone_number = current_user.phone_number
    render 'events_page'
  end

  def settings
    @user = User.find(params[:id])
  end

  def update
    User.find(params[:id]).update_attributes(params[:user])
    @user = User.find(params[:id])
    @saved_message = 'your settings have been saved'
    render 'settings'
  end
end
