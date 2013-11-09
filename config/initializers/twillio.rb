env_config = YAML.load_file("config/twilio.yaml")

env_config.each do |k, v|
	ENV[k] = v
end