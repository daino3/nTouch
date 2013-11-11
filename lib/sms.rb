class Sms

# the indentation on this page is terrible

	# this is being referenced by the ApplicationController(not really though)
def send_text_message(phone_number, friend_id)
	@phone_number = phone_number
	@friend = Friend.find(friend_id)

		twilio_sid = ENV['TWILIO_SID']
		twilio_token = ENV['TWILIO_TOKEN']
		twilio_phone_number = ENV['PHONE_NUMBER']

		@client = Twilio::REST::Client.new twilio_sid, twilio_token
		@client.account.sms.messages.create(
			:from => "+1#{twilio_phone_number}",
      		:to => "+1#{@phone_number}",
      		:body => "YYYYYYYYYEEEEEEEEEEEEEESSSSSSSSSSSSSSSSSS!!!!!11"
    	) #interpolate the user phone number
	end

end
