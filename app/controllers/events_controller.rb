class EventsController < ApplicationController

	def new
		@friend = Friend.find(params[:friend_id]) || Friend.find(params[:friendId]) # why are you accepting two formattings of this url param? its weird
		@event = Event.new
		render '_new_event' # render :partial => "new_event"
	end

	def create
		friend = Friend.find(params[:friend_id])
		friend.events.create!(params[:event].permit(:date, :description, :notification_date, :notificationtype, :frequency, :title))
		redirect_to user_events_path(current_user)
	end

	def show
		@friend = Friend.find(params[:friend_id]) || Friend.find(params[:friendId]) # why are you accepting two formattings of this url param? its weird
		@event = Event.find(params[:id])
		render '_update_event' # render :partial => "update_event"
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
