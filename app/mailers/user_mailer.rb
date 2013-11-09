class UserMailer < ActionMailer::Base
  default from: "dainovu3@gmail.com"

  def reminder_email(user_id, friend_id)
    @user = User.find(user_id)
    @friend = Friend.find(friend_id)
    @email = @user.email
    @url  = 'http://localhost:3000'
    mail(to: @email, subject: 'NTouch: Birthday Reminder')
  end
end
