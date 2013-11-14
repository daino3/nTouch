class EventsController < ApplicationController

	def new
		form_type = params[:form]
		@friend = Friend.find(params[:friend_id])
		if form_type == Event::EVENT_TYPE[1]
			@event = Event.new(eventtype: form_type)
			render partial: 'new_frequent_event'
		elsif form_type == Event::EVENT_TYPE[2]
			@event = Event.new(eventtype: form_type)
			render partial: 'new_annual_event'
		end
	end

	def create
		friend = Friend.find(params[:friend_id])
		friend.events.create!(params[:event].permit(:date, :description, :notification_date, :notificationtype, :frequency, :title, :eventtype))
		event = Event.last

		if event.frequent?
			event.date = event.notification_date
			event.save!
		end

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
		event = Event.find(params[:id])
		event.update_attributes(params[:event].permit(:date, :description, :notification_date, :notificationtype, :frequency, :title, :eventtype))

		if event.frequent?
			event.date = event.notification_date
			event.save!
		end

		redirect_to user_events_path(current_user)
	end

	def destroy
		Event.find(params[:id]).destroy
		redirect_to user_events_path(current_user)
	end
end
