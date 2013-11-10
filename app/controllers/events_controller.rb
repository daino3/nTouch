class EventsController < ApplicationController

 def new
   @friend = Friend.find(params[:friend_id])
   @event = Event.new
 end

 def create
   friend = Friend.find(params[:friend_id])
   friend.events.create!(params[:event].permit(:date, :description, :notification_date, :notificationtype))
   redirect_to user_path(current_user)
 end

 end

#hidden field that permits the date to live in it - then we save it