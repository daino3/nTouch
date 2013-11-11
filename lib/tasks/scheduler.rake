  namespace :db do
	desc "Stores a users' events whose notification date is today into redis"
	task event_search: :environment do
    $redis.FLUSHALL
		puts "Searching for events..."
    Event.all.each do |event|
      if event.notification_date.month == DateTime.now.month && event.notification_date.day == DateTime.now.day
        $redis.lpush("user_#{event.friend.user.id}_event_ids", event.id)
      end
    end
	end
end

namespace :redis do
  desc "Go through redis and send emails and texts"
  task send_reminders: :environment do
    puts "Sending out emails and texts..."
    $redis.keys.each do |key|
      event_ids = $redis.lrange(key, 0, -1)
      event_id_integers = event_ids.map(&:to_i)

      event_id_integers.each do |id|
        event = Event.find(id)
        friend = event.friend
        user = event.friend.user
        if event.notificationtype == "Both"
          Sms.new.send_text_message(user.phone_number, friend.id)
          UserMailer.reminder_email(user.id, friend.id)
        elsif event.notificationtype == "Email"
          UserMailer.reminder_email(user.id, friend.id)
        elsif event.notificationtype == "Text Message"
          Sms.new.send_text_message(user.phone_number, friend.id)
        end
        ReminderReceipt.create(event_id: event.id, status: true)
        event.update_schedule
      end
    end
  end
end
