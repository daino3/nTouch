class UserMailer < ActionMailer::Base

  include SendGrid
  sendgrid_category :use_subject_lines
  sendgrid_enable   :ganalytics, :opentrack
  sendgrid_unique_args :key1 => "value1", :key2 => "value2"

  default from: "ntouchdbc@gmail.com"

  def annual_email(user, event)
    @user = user
    @event = event
    mail(to: @user.email, 
         subject: "NTouch: #{@event.description} Reminder",
         template_path: 'user_mailer',
         template_name: 'annual_email')
  end

  def frequent_email(user, event)
    @user = user
    @event = event
    mail(to: @user.email, 
         subject: "NTouch: #{@event.frequency} Reminder",
         template_path: 'user_mailer',
         template_name: 'frequent_email')
  end
end
