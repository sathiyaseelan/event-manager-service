$redis = Redis::Namespace.new("event_manager", :redis => Redis.new(:host => 'localhost', :port => 6379))
