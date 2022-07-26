require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { :size => 1 } #, url: ENV['REDIS_URL']

  config.redis = { url: 'redis://localhost:6379/0' }
end

Sidekiq.configure_server do |config|

  config.redis = { url: 'redis://localhost:6379/0' }
end
