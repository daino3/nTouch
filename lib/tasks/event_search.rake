$REDIS = Redis.new(:host => "localhost", :port => 6379)

namespace :event_search do 
	desc "Heyyyyyyyyyyyyyyyyy!!!!!!!!!!!!!!!"
	task event_search: :environment do
		puts "Searching for events..."
		$REDIS.set("birthday", Event.all.find_by_date(Time.now.to_date))
		puts $REDIS.get("birthday")
	end
end

#redis needs to be a GLOBAL variable so that we can access it from elsewhere