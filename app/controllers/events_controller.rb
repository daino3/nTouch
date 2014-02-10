require 'pry'

class EventsController < ApplicationController

	def new
		@friend = Friend.find(params[:friend_id])
		@event = Event.determine_type(params)
		if @event.eventtype == Event::EVENT_TYPE[1] 
			render partial: 'new_frequent_event'
		else 
			render partial: 'new_annual_event'
		end
	end

	def create
		Event.create_event_for_user(params)
		redirect_to user_events_path(current_user)
	end

	def show
		@friend = Friend.find(params[:friend_id])
		@event = Event.find(params[:id])

		if @event.frequent?
			render partial: 'update_frequent_event'
		elsif @event.annual?
			render partial: 'update_annual_event'
		end
	end

	def update
		Event.update_event(params)
		redirect_to user_events_path(current_user)
	end

	def destroy
		Event.find(params[:id]).destroy
		redirect_to user_events_path(current_user)
	end
end
