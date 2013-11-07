OmniAuth.config.logger = Rails.logger

env_config = YAML.load_file("config/facebook.yaml")

env_config.each do |key, value|
  ENV[key]=value
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET']
end
