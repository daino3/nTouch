OmniAuth.config.logger = Rails.logger

env_config = YAML.load_file("config/facebook.yaml")

env_config.each do |key, value|
  ENV[key]=value
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET']
end

# env_config2 = YAML.load_file("config/twilio.yaml")

# env_config2.each do |key, value|
# 	ENV[key]=value
# end

# Rails.application.config.middleware.use Twilio::Client do
# 	provider :twilio, ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
# end