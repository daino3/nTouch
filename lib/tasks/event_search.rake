

namespace :db do
	desc "Stores a users' events whose notification date is today into redis"
	task event_search: :environment do
		puts "Searching for events..."
    Event.all.each do |event|
      if event.date.month == DateTime.now.month && event.date.day == DateTime.now.day
        $redis.lpush("user_#{event.friend.user.id}_birthday_ids", event.id)
      end
    end
    puts $redis.lrange("user_3_birthday_ids", 0, -1)
	end
end

namespace :redis do
  desc "Go through redis and send emails and texts"
  task send_birthday_email: :environment do
    puts "Sending out emails and texts..."
    $redis.keys.each do |key|
      event_ids = $redis.lrange(key, 0, -1)
      event_id_integers = event_ids.map(&:to_i)

      event_id_integers.each do |id|
        event = Event.find(id)
        friend = event.friend
        user = event.friend.user
        if event.email == true && event.text == true
          UserMailer.reminder_email(user.id, friend.id)
          send_text_message(user.phone_number, friend.id)
        elsif event.email == true
          UserMailer.reminder_email(user.id, friend.id)
        elsif event.text == true
          send_text_message(user.phone_number, friend.id)
        end
        ReminderReceipt.create(event_id: event.id, status: true)
      end
    end

  end
end
