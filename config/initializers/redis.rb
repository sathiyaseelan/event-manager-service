$redis = Redis::Namespace.new("event_manager", :redis => Redis.new(:url =>ENV['REDIS_URL']))
