class Event < ActiveRecord::Base
	belongs_to :friend
	has_many :reminder_receipts

  attr_accessible :friend_id, :date, :description, :notification_date, :notificationtype
  validates_presence_of :description, :friend_id, :notification_date, :notificationtype

end


