class Event < ActiveRecord::Base
  include IceCube
  belongs_to :friend
  has_many :reminder_receipts

  attr_accessible :friend_id, :date, :description, :notification_date, :notificationtype, :frequency, :title, :eventtype
  validates_presence_of :description, :friend_id, :notificationtype, :notification_date, :eventtype

  before_save :force_utc

  def force_utc
    self.notification_date = self.notification_date.utc
  end

  def update_schedule
    schedule = Schedule.new(self.notification_date)

    # use a switch statement. google it and also consider not using strings; symbols or constants would emphasize these values better
    if self.frequency == "Weekly"
      schedule.add_recurrence_rule Rule.weekly
      self.update_attributes(notification_date: schedule.first(2).pop)
    elsif self.frequency == "Bi-weekly"
      schedule.add_recurrence_rule Rule.weekly(2)
      self.update_attributes(notification_date: schedule.first(2).pop)
    elsif self.frequency == "Monthly"
      schedule.add_recurrence_rule Rule.monthly
      self.update_attributes(notification_date: schedule.first(2).pop)
    elsif self.frequency == "Quarterly"
      schedule.add_recurrence_rule Rule.monthly(3)
      self.update_attributes(notification_date: schedule.first(2).pop)
    elsif self.frequency == "Bi-annually"
      schedule.add_recurrence_rule Rule.monthly(6)
      self.update_attributes(notification_date: schedule.first(2).pop)
    end
  end


end


