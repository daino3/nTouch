  class UsersController < ApplicationController

  def show
  end

  def interaction_data
    friend_uid = params[:data]
    graph = Koala::Facebook::API.new(current_user.oauth_token)
    unix_time = (Time.now() - 3.months).to_i

    posts_from_friend_to_me = "SELECT message
                              FROM stream 
                              WHERE actor_id=#{friend_uid.to_i} AND source_id=me() AND created_time > #{unix_time} LIMIT 200"
    posts_from_me_to_friend = "SELECT message
                              FROM stream 
                              WHERE actor_id=me() AND source_id=#{friend_uid.to_i} AND created_time > #{unix_time} LIMIT 200"
    
    posts_from_friend = graph.fql_query(posts_from_friend_to_me).count
    posts_from_me = graph.fql_query(posts_from_me_to_friend).count
    @graph_data = [friend_uid, posts_from_friend, posts_from_me]

    @graph_data
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
