class Reminder < ActiveRecord::Base
	belongs_to :event

	validates_presence_of :notification_date
end