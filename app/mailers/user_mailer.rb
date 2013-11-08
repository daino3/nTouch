class UserMailer < ActionMailer::Base
  default from: "dainovu3@gmail.com"

  def test_email(user_id)
    @user = User.find(user_id)
    @email = @user.email
    @url  = 'http://localhost:3000'
    mail(to: @email, subject: 'Welcome to My Awesome Site')
  end
end
