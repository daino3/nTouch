desc "Sends reminders for current events"
task send_reminders: :environment do
  puts "Searching for events..."
  Event.all.each do |event|
    if event.notification_date.month == DateTime.now.utc.month && event.notification_date.day == DateTime.now.utc.day && event.notification_date.hour <= Time.now.utc.hour
      MessageWorker.perform_async(event.id)
    end
  end
end
