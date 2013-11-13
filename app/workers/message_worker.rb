class MessageWorker
  include Sidekiq::Worker

  def perform(event_id)
    event = Event.find(event_id)
    user = event.friend.user
    if event.notificationtype == Event::NOTIFICATION_TYPE[0]
      Sms.new.send_text_message(user.phone_number, event)
      if event.eventtype == Event::EVENT_TYPE[2]
        UserMailer.annual_email(user, event)
      elsif event.eventtype == Event::EVENT_TYPE[1]
        UserMailer.frequent_email(user, event)
      end
    elsif event.notificationtype == Event::NOTIFICATION_TYPE[2]
      if event.eventtype == Event::EVENT_TYPE[2]
        UserMailer.annual_email(user, event)
      elsif event.eventtype == Event::EVENT_TYPE[1]
        UserMailer.anniversary_email(user, event)
      end
    elsif event.notificationtype == Event::NOTIFICATION_TYPE[1]
      Sms.new.send_text_message(user.phone_number, event)
    end
    ReminderReceipt.create(event_id: event.id, status: true)
    event.update_schedule
  end
end
