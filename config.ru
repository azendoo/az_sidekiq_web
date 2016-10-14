require 'yaml'
require 'sidekiq'
require 'sidekiq/failures'

env = ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV['AZ_APP_2_REDIS_URL'],
    namespace: "sidekiq:az_app_2_#{env}",
    size: 1
  }
end

require 'sidekiq/web'
run Sidekiq::Web
