class FriendsController < ApplicationController

  def index
    graph    = connect_to_facebook
    @friends = graph.get_connections('me', 'friends')
  end

  def search
    selected_friend = params[:facebookUser]
    graph       = connect_to_facebook
    @friend     = graph.get_object(selected_friend)
    @photo      = graph.get_picture(selected_friend, type: 'large')
    render partial: 'new_friend'
  end

  def create
    if current_user.friends.count < 10
      notice = Friend.check_new_friend(current_user, Friend.new(new_friend_params))
      redirect_to user_friends_path(current_user), notice: notice
    else
      redirect_to user_friends_path(current_user), notice: "You already have 10 friends - Go to your manage friends tab to manage your connections"
    end
  end

  def show
    @friend = Friend.find(params[:id])
    render partial: 'edit_friend'
  end

  def destroy
    Friend.find(params[:id]).destroy
    redirect_to user_path(current_user)
  end

  def update
    @saved_friend  = Friend.update_friend(params)
    @saved_message = "Your friend's settings have been saved"
    render template: 'friends/index'
  end

  private

  def new_friend_params
     params.require(:new_friend).permit(:first_name, :last_name, :birthday, :photo_url, :uid, :phone_number)
  end
end
