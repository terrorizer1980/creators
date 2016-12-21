TRIAL = Rails.application.config_for :trial_config
HIPCHAT = Rails.application.config_for :hipchat_config

HIPCHAT_CLIENT = HipChat::Client.new(HIPCHAT[:api_key], :api_version => HIPCHAT[:api_version])

# Sadly, the below doesn't work (in Windows dev, at least)
#config_reloader = ActiveSupport::FileUpdateChecker.new(Dir["config/trial_config.yml"]) do
#  puts('config_reloader callback')
#  #I18n.backend.reload!
#end
#
#ActionDispatch::Callbacks.to_prepare do
#  puts('config_reloader execute_if_updated')
#  config_reloader.execute_if_updated
#end