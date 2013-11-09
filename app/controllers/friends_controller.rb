class FriendsController < ApplicationController

  def create
    if current_user.friends.count < 11
      @friend = Friend.new(new_friend_params)
      current_user.friends << @friend
      @friend.save
      redirect_to user_path(current_user)
    else
      @error = "You cannot add any more friends"
      render "users/show"
    end
  end

  private
  def new_friend_params
     params.require(:new_friend).permit(:first_name, :last_name, :birthday, :photo_url)
  end

end
