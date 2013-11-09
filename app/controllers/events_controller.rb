class EventsController < ApplicationController

 def new
   @friend = Friend.find(params[:friend_id])
   @event = Event.new
 end

 def create
   friend = Friend.find(params[:friend_id])
   friend.events.create!(params[:event].permit(:date, :description, :notification_date))
   redirect_to user_path(current_user)
 end

 end
