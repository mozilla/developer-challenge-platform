github_config = YAML.load_file(File.join(Rails.root, "config/github.yml"))[Rails.env] rescue nil || {}
twitter_config = YAML.load_file(File.join(Rails.root, "config/twitter.yml"))[Rails.env] rescue nil || {}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, github_config['client_id'], github_config['secret']
  provider :twitter, twitter_config['consumer_key'], twitter_config['consumer_secret']
end