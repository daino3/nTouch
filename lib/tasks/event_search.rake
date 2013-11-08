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
  desc "Go through redis and send emails"
  task send_birthday_email: :environment do
    puts "Sending out emails..."
    $redis.keys.each do |key|
      event_ids = $redis.lrange(key, 0, -1)
      event_id_integers = event_ids.map(&:to_i)

      event_id_integers.each do |id|
        puts Event.find(id)
        #.send_email
        # create_email
      end
    end

  end
end

#this needs to be put in the email controller
def self.send_email
  puts "yeah"
end

def create_reminder_reciept
end






#redis needs to be a GLOBAL variable so that we can access it from elsewhere


