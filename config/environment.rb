# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
NTouch::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :domain => ENV['SENDGRID_DOMAIN'],
  :user_name =>  ENV['SENDGRID_USERNAME'],
  :password => ENV['SENDGRID_PASSWORD'],
  :enable_starttls_auto => true
}