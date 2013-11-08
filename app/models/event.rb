class Event < ActiveRecord::Base
	belongs_to :friend
	has_one :reminder

  attr_accessible :title, :date, :friend_id

	validates_presence_of :title, :date, :friend_id
end
