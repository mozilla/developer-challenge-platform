github_config = YAML.load_file(File.join(Rails.root, "config/github.yml"))[Rails.env] rescue nil || {}
twitter_config = YAML.load_file(File.join(Rails.root, "config/twitter.yml"))[Rails.env] rescue nil || {}

github_client_id = ENV['github_client_id'] || github_config['client_id']
github_secret = ENV['github_secret'] || github_config['secret']

twitter_consumer_key = ENV['twitter_consumer_key'] || twitter_config['consumer_key']
twitter_consumer_secret = ENV['twitter_consumer_secret'] || twitter_config['consumer_secret']

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, github_client_id, github_secret
  provider :twitter, twitter_consumer_key, twitter_consumer_secret
end