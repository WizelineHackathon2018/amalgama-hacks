Sidekiq.configure_server do |config|
  config.redis = { url: Settings.sidekiq_redis_server_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: Settings.sidekiq_redis_server_url }
end

Sidekiq::Extensions.enable_delay!