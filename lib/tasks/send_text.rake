require ApplicationHelper

namespace :text do
	desc "Send user reminder text message"
	task send_text_message: :environment do
		puts "Sending out texts..."
		$redis.keys.each do |key|
  		event_ids = $redis.lrange(key, 0, -1)
  		event_id_integers = event_ids.map(&:to_i)

  		event_id_integers.each do |id|
    	puts Event.find(id)
    # create_text
    #.send_text
  end
end




end


