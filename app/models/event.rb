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

  def self.determine_type(params)
    form_type = params[:form]
    if form_type == Event::EVENT_TYPE[1]
      event = Event.new(eventtype: form_type)
    elsif form_type == Event::EVENT_TYPE[2]
      event = Event.new(eventtype: form_type)
    end
    event
  end

  def self.create_event_for_user(params)
    friend = Friend.find(params[:friend_id])
    friend.events.create!(params[:event].permit(:date, :description, :notification_date, :notificationtype, :frequency, :title, :eventtype))
    event = Event.last

    if event.frequent?
      event.date = event.notification_date
      event.save!
    end
  end

  def self.update_event(params)
    event = Event.find(params[:id])
    event.update_attributes(params[:event].permit(:date, :description, :notification_date, :notificationtype, :frequency, :title, :eventtype))

    if event.frequent?
      event.date = event.notification_date
      event.save!
    end
  end
end


