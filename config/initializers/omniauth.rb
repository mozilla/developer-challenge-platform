github_config = YAML.load_file(File.join(Rails.root, "config/github.yml"))[Rails.env] rescue nil || {}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, github_config['client_id'], github_config['secret']
end