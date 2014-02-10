  class UsersController < ApplicationController

  def show
  end

  def interaction_data
    friend_uid = params[:data]
    @graph_data = Friend.get_facebook_interactions(connect_to_facebook, friend_uid)
    render partial: "interaction_graph"
  end

  def show_events
    @user    = current_user
    @friends = current_user.friends
    @email   = current_user.email
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