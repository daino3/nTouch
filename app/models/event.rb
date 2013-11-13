class Event < ActiveRecord::Base
  include IceCube
  belongs_to :friend
  has_many :reminder_receipts, dependent: :destroy

  attr_accessible :friend_id, :date, :description, :notification_date, :notificationtype, :frequency, :title, :eventtype
  validates_presence_of :description, :friend_id, :notificationtype, :notification_date, :eventtype

  before_save :force_utc

  EVENT_TYPE = ["","Frequent", "Annual"]
  EVENT_FREQUENCY = ["Weekly", "Bi-weekly", "Monthly", "Quarterly", "Bi-annually"]
  NOTIFICATION_TYPE = ["Both", "Text Message", "Email"]

  def force_utc
    self.notification_date = self.notification_date.utc
  end

  def frequent?
    self.eventtype == EVENT_TYPE[1]
  end

  def annual?
    self.eventtype == EVENT_TYPE[2]
  end

  def update_schedule
    schedule = Schedule.new(self.notification_date)
    if self.eventtype == EVENT_TYPE[1]
      case self.frequency
        when EVENT_FREQUENCY[0]
          schedule.add_recurrence_rule Rule.weekly
          self.update_attributes(notification_date: schedule.first(2).pop)
        when EVENT_FREQUENCY[1]
          schedule.add_recurrence_rule Rule.weekly(2)
          self.update_attributes(notification_date: schedule.first(2).pop)
        when EVENT_FREQUENCY[2]
         schedule.add_recurrence_rule Rule.monthly
          self.update_attributes(notification_date: schedule.first(2).pop)
        when EVENT_FREQUENCY[3]
          schedule.add_recurrence_rule Rule.monthly(3)
          self.update_attributes(notification_date: schedule.first(2).pop)
        when EVENT_FREQUENCY[4]
          schedule.add_recurrence_rule Rule.monthly(6)
          self.update_attributes(notification_date: schedule.first(2).pop)
      end
    elsif self.eventtype == EVENT_TYPE[2]
      schedule.add_recurrence_rule Rule.yearly
      self.update_attributes(notification_date: schedule.first(2).pop)
    end
  end
end


