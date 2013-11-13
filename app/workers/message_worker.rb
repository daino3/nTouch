class MessageWorker
  include Sidekiq::Worker

  def perform(event_id)
    event = Event.find(id)
    friend = event.friend
    user = event.friend.user
    if event.notificationtype == "Both"
      Sms.new.send_text_message(user.phone_number, friend, event)
      if event.description == "Birthday"
        UserMailer.birthday_email(user, friend)
      elsif event.description == "Anniversary"
        UserMailer.anniversary_email(user, friend, event)
      elsif event.description == "Other"
        UserMailer.other_email(user, friend, event)
      end
    elsif event.notificationtype == "Email"
      if event.description == "Birthday"
        UserMailer.birthday_email(user, friend)
      elsif event.description == "Anniversary"
        UserMailer.anniversary_email(user, friend, event)
      elsif event.description == "Other"
        UserMailer.other_email(user, friend, event)
      end
    elsif event.notificationtype == "Text Message"
      Sms.new.send_text_message(user.phone_number, friend, event)
    end
    ReminderReceipt.create(event_id: event.id, status: true)
    event.update_schedule
  end
end
