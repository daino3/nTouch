  class UsersController < ApplicationController

  def show
    graph = Koala::Facebook::API.new(current_user.oauth_token)
    @friends = graph.get_connections('me', 'friends')
    @unix_time = (Time.now() - 3.months).to_i
    @graph_data = {}

    current_user.friends.each do |friend|
      facebook_friend_id = friend.uid
      posts_from_friend_to_me = "SELECT message
                                FROM stream 
                                WHERE actor_id=#{facebook_friend_id.to_i} AND source_id=me() AND created_time > #{@unix_time} LIMIT 200"
      posts_from_me_to_friend  = "SELECT message
                                  FROM stream 
                                  WHERE actor_id=me() AND source_id=#{facebook_friend_id.to_i} AND created_time > #{@unix_time} LIMIT 200"
      posts_from_friend = graph.fql_query(posts_from_friend_to_me).count
      posts_from_me = graph.fql_query(posts_from_me_to_friend).count
      @graph_data[facebook_friend_id] = [posts_from_friend, posts_from_me]
    end
    @graph_data
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
