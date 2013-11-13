class UserMailer < ActionMailer::Base

  include SendGrid
  sendgrid_category :use_subject_lines
  sendgrid_enable   :ganalytics, :opentrack
  sendgrid_unique_args :key1 => "value1", :key2 => "value2"

  default from: "ntouchdbc@gmail.com"

  def birthday_email(user, friend)
    @user = user
    @friend = friend
    mail(to: @user.email, 
         subject: 'NTouch: Birthday Reminder',
         template_path: 'user_mailer',
         template_name: 'birthday_email')
  end

  def anniversary_email(user, friend, event)
    @user = user
    @friend = friend
    @event = event
    mail(to: @user.email, 
        subject: 'NTouch: Anniversary Reminder',
        template_path: 'user_mailer',
        template_name: 'anniversary_email')
  end

  def other_email(user, friend, event)
    @user = user
    @friend = friend
    @event = event
    mail(to: @user.email, 
         subject: "NTouch: #{@event.frequency} Reminder",
         template_path: 'user_mailer',
         template_name: 'other_email')
  end
end
