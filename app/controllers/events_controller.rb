class EventsController < ApplicationController

	def new
		@friend = Friend.find(params[:friend_id])
		@event = Event.new
		render partial: 'new_event'
	end

	def create
		friend = Friend.find(params[:friend_id])
		friend.events.create!(params[:event].permit(:date, :description, :notification_date, :notificationtype, :frequency, :title))
		redirect_to user_events_path(current_user)
	end

	def show
		@friend = Friend.find(params[:friend_id])
		@event = Event.find(params[:id])
		render partial: 'update_event'
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
