class UserMailer < ActionMailer::Base
  default from: "dainovu3@gmail.com"

  def reminder_email(user_id, friend_id)
    @user = User.find(user_id)
    @friend = Friend.find(friend_id) # it'd be better to pass in Friend object instances into this method rather than create instances here
    @email = @user.email
    @url  = 'http://localhost:3000' # this is bad -- please find a way to handle this environment-specific configuration better
    mail(to: @email, subject: 'NTouch: Birthday Reminder')
  end
end
