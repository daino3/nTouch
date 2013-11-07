class Event < ActiveRecord::Base
	belongs_to :friend
	has_one :reminder
end