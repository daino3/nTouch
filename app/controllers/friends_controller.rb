class FriendsController < ApplicationController

  def index
    @graph = Koala::Facebook::API.new(current_user.oauth_token)
    @friends = @graph.get_connections('me', 'friends')
  end

  def create
    if current_user.friends.count < 10
      new_friend = Friend.new(new_friend_params)
      if current_user.friends.find_by_uid(new_friend.uid)
        flash[:notice]="#{new_friend.first_name} is already included in your list. Please select someone who is not."
        redirect_to user_friends_path(current_user)
      else
        new_friend.save
        current_user.friends << new_friend
        flash[:notice]="#{new_friend.first_name} has been added to your list"
        redirect_to user_path(current_user)
      end
    else
      redirect_to user_path(current_user)
    end
  end

  private
  def new_friend_params
     params.require(:new_friend).permit(:first_name, :last_name, :birthday, :photo_url, :uid)
  end

end
