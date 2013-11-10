class EventsController < ApplicationController

	def new
		@friend = Friend.find(params[:friend_id]) || Friend.find(params[:friendId])
		@event = Event.new
		render '_new_event'
	end

	def create
		friend = Friend.find(params[:friend_id])
		friend.events.create!(params[:event].permit(:date, :description, :notification_date, :notificationtype))
		redirect_to user_events_path(current_user)
	end

	def show
		@friend = Friend.find(params[:friend_id]) || Friend.find(params[:friendId])
		@event = Event.find(params[:id])
		render '_update_event'
	end

	def update
		event = Event.find(params[:id])
		event.update_attributes(params[:event])
		redirect_to user_events_path(current_user)
	end

	def destroy
		Event.find(params[:id]).destroy
		redirect_to user_events_path(current_user)
	end

end

#hidden field that permits the date to live in it - then we save it
