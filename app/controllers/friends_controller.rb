class FriendsController < ApplicationController

  def index
    @graph = Koala::Facebook::API.new(current_user.oauth_token)
    @friends = @graph.get_connections('me', 'friends')
  end

  def search
    selected_friend = params[:facebookUser]
    @graph      = Koala::Facebook::API.new(current_user.oauth_token)
    @friend     = @graph.get_object(selected_friend)
    @photo      = @graph.get_picture(selected_friend, type: 'large')
    render '_new_friend'
  end

  def create
    if current_user.friends.count < 10
      new_friend = Friend.new(first_name: params[:new_friend][:first_name],
        last_name: params[:new_friend][:last_name],
        birthday: Chronic.parse(params[:new_friend][:birthday]),
        photo_url: params[:new_friend][:photo_url],
        uid: params[:new_friend][:uid])
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
      flash[:notice]="You already have 10 friends - Go to your manage friends tab to manage your connections"
      redirect_to user_friends_path(current_user)
    end
  end

  def show
    @friend = Friend.find(params[:id])
  end

  def destroy
    Friend.find(params[:id]).destroy
    redirect_to user_path(current_user)
  end

  def update
    friend = Friend.find(params[:id])
    @friend = Friend.find(params[:id]).update_attributes(params[:friend])
    redirect_to user_path(current_user)
  end

  private
  def new_friend_params
     params.require(:new_friend).permit(:first_name, :last_name, :birthday, :photo_url, :uid, :phone_number)
  end

end
