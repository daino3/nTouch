class UserMailer < ActionMailer::Base
  default from: "ntouchdbc@gmail.com"

  def birthday_email(user, friend)
    @user = user
    @friend = friend
    mail(to: @user.email, subject: 'NTouch: Birthday Reminder')
  end

  def anniversary_email(user, friend, event)
    @user = user
    @friend = friend
    @event = event
    mail(to: @user.email, subject: 'NTouch: Anniversary Reminder')
  end

  def other_email(user, friend, event)
    @user = user
    @friend = friend
    @event = event
    mail(to: @user.email, subject: "NTouch: #{@event.frequency} Reminder")
  end
end
