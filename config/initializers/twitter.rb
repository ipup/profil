# config/initializers/twitter.rb

module TwitterEnv
 CONFIG = YAML.load_file(Rails.root + "config/twitter.yml")[Rails.env]
 API_KEY = CONFIG['api_key']
 SECRET_KEY = CONFIG['secret_key']
 CALLBACK_URL = CONFIG['callback_url']
end

Twitter.configure do |c|
  c.consumer_key = TwitterEnv::API_KEY
  c.consumer_secret = TwitterEnv::SECRET_KEY
end

