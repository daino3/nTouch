class FriendsController < ApplicationController

  def index
    @graph = Koala::Facebook::API.new(current_user.oauth_token)
    @friends = @graph.get_connections('me', 'friends')
  end

  def search
    selected_friend = params[:facebookUser]
    @graph      = Koala::Facebook::API.new(current_user.oauth_token) # does this have to be an instance variable?
    @friend     = @graph.get_object(selected_friend)
    @photo      = @graph.get_picture(selected_friend, type: 'large')
    render '_new_friend' # render :partial => "new_friend"
  end

  def create
    if current_user.friends.count < 10
      new_friend = Friend.new(new_friend_params, birthday: Chronic.parse(params[:new_friend][:birthday]))

      if current_user.friends.find_by_uid(new_friend.uid)
        # if youd like you can refactor these to be one liners, eg:
        # redirect_to something_url, :notice => "some message"
        flash[:notice] = "#{new_friend.first_name} is already included in your list. Please select someone who is not."
        redirect_to user_friends_path(current_user)
      else
        new_friend.save
        current_user.friends << new_friend
        flash[:notice] = "#{new_friend.first_name} has been added to your list"
        redirect_to user_path(current_user)
      end
    else
      flash[:notice] = "You already have 10 friends - Go to your manage friends tab to manage your connections"
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
    friend = Friend.find(params[:id]) # ? whats this line for?
    @friend = Friend.find(params[:id]).update_attributes(params[:friend])
    redirect_to user_path(current_user)
  end

  private

  def new_friend_params
     params.require(:new_friend).permit(:first_name, :last_name, :birthday, :photo_url, :uid, :phone_number)
  end
end
