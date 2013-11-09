class Sms

	# this is being referenced by the ApplicationController(not really though)
def send_text_message(phone_number, friend)
	@phone = phone
	@friend = Friend.find(friend)

		twilio_sid = ENV['TWILIO_SID']
		twilio_token = ENV['TWILIO_TOKEN']
		twilio_phone_number = ENV['PHONE_NUMBER']

		@client = Twilio::REST::Client.new twilio_sid, twilio_token
		@client.account.sms.messages.create(
			:from => "+1#{twilio_phone_number}",
      		:to => "+1#{@phone}",
      		:body => "YYYYYYYYYEEEEEEEEEEEEEESSSSSSSSSSSSSSSSSS!!!!!11"
    	) #interpolate the user phone number
	end

end