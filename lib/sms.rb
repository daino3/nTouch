class Sms

  def send_text_message(phone_number, event)

 
     twilio_sid = ENV['TWILIO_SID']
     twilio_token = ENV['TWILIO_TOKEN']
     twilio_phone_number = ENV['PHONE_NUMBER']
 
    client = Twilio::REST::Client.new twilio_sid, twilio_token

    if event.eventtype == Event::EVENT_TYPE[2]
      client.account.sms.messages.create(
        :from => "+1#{twilio_phone_number}",
        :to => "+1#{phone_number}",
        :body => "Reminder: #{event.friend.first_name}'s #{event.description} is #{event.date.strftime('%A, %b %d')}"
        )
    elsif event.eventtype == Event::EVENT_TYPE[1]
      client.account.sms.messages.create(
        :from => "+1#{twilio_phone_number}",
        :to => "+1#{phone_number}",
        :body => "#{event.frequency} reminder to #{event.description}"
        )
    end
  end
end
