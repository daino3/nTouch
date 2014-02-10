require 'pry'

class EventsController < ApplicationController

  def new
    @friend = Friend.find(params[:friend_id])
    @event = Event.determine_type(params)
    render partial: @event.get_new_partial
  end

  def create
    Event.create_event_for_user(params)
    redirect_to user_events_path(current_user)
  end

  def show
    @friend = Friend.find(params[:friend_id])
    @event = Event.find(params[:id])
    render partial: @event.get_update_partial
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
