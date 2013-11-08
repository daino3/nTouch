class Event < ActiveRecord::Base
	belongs_to :friend
	has_many :reminder_receipts

	attr_accessible :friend_id, :first_name, :last_name, :title, :description, :date, :notification_date

	validates_presence_of :title, :date, :friend_id
end