# config/initializers/linkedin.rb

module LinkedIn
 CONFIG = YAML.load_file(Rails.root + "config/linkedin.yml")[Rails.env]
 API_KEY = CONFIG['api_key']
 SECRET_KEY = CONFIG['secret_key']
 CALLBACK_URL = CONFIG['callback_url']
end

