class Sms

  def send_text_message(phone_number, friend, event)
    @phone_number = phone_number
    @event = event
    @friend = friend
 
     twilio_sid = ENV['TWILIO_SID']
     twilio_token = ENV['TWILIO_TOKEN']
     twilio_phone_number = ENV['PHONE_NUMBER']
 
    @client = Twilio::REST::Client.new twilio_sid, twilio_token

    if @event.description == "Birthday"
      @client.account.sms.messages.create(
        :from => "+1#{twilio_phone_number}",
        :to => "+1#{@phone_number}",
        :body => "Reminder: #{@friend.first_name}'s birthday is #{@friend.birthday.strftime('%A, %b %d')}"
        )
    elsif @event.description == "Anniversary"
      @client.account.sms.messages.create(
        :from => "+1#{twilio_phone_number}",
        :to => "+1#{@phone_number}",
        :body => "Reminder: #{@friend.first_name}'s anniversary is #{@event.date.strftime('%A, %b %d')}"
        )
    elsif @event.description == "Other"
      @client.account.sms.messages.create(
        :from => "+1#{twilio_phone_number}",
        :to => "+1#{@phone_number}",
        :body => "#{@event.frequency} reminder to contact #{@friend.first_name}"
        )
    end
  end
end
