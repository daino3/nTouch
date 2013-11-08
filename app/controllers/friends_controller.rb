class FriendsController < ApplicationController

  def create
    @friend = Friend.new(new_friend_params)
    current_user.friends << @friend
    @friend.save
    redirect_to user_path(current_user)
  end

    private
    def new_friend_params
      params.require(:new_friend).permit(:first_name, :last_name, :birthday)
    end

end
