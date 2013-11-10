class FriendsController < ApplicationController

  def create
    if current_user.friends.count < 10
      current_user.friends.find_or_create_by_first_name_and_last_name_and_birthday_and_photo_url(new_friend_params)
        redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end

  private
  def new_friend_params
     params.require(:new_friend).permit(:first_name, :last_name, :birthday, :photo_url)
  end

end
