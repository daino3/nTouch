class Event < ActiveRecord::Base
	belongs_to :friend
	has_one :reminder

	validates_presence_of :title, :date, :friend_id
end