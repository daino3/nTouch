class FriendsController < ApplicationController

  def index
    p '-----------------'
    p params
    p @friends
    p current_user
    p current_user.oauth_token
    p '-----------------'
    graph    = Koala::Facebook::API.new(current_user.oauth_token)
    @friends = graph.get_connections('me', 'friends')

  end

  def search
    selected_friend = params[:facebookUser]
    graph       = Koala::Facebook::API.new(current_user.oauth_token)
    @friend     = graph.get_object(selected_friend)
    @photo      = graph.get_picture(selected_friend, type: 'large')
    render partial: 'new_friend'
  end

  def create
    if current_user.friends.count < 10
      new_friend = Friend.new(new_friend_params)
      new_friend.update_attributes(birthday: Chronic.parse(params[:new_friend][:birthday]).to_date)

      if current_user.friends.find_by_uid(new_friend.uid)
        redirect_to user_friends_path(current_user), notice: "#{new_friend.first_name} is already included in your list. Please select someone who is not."
      else
        new_friend.save
        current_user.friends << new_friend
        redirect_to user_path(current_user), notice: "#{new_friend.first_name} has been added to your list"
      end
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
    @saved_friend = Friend.find(params[:id]).update_attributes(params[:friend])
    @friend = Friend.find(params[:id])
    @saved_message = "Your friend's settings have been saved"
    render template: 'friends/index'
  end

  private
  def new_friend_params
     params.require(:new_friend).permit(:first_name, :last_name, :birthday, :photo_url, :uid, :phone_number)
  end
end
