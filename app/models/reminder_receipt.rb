class ReminderReceipt < ActiveRecord::Base
  belongs_to :event

  attr_accessible :event_id, :status, :email, :text

  validates_presence_of :event_id, :status
end