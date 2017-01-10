$redis = Redis::Namespace.new("event_manager", :redis => Redis.new(:url =>ENV['REDIS_URL']))


# Load all the categories into redis

$redis.del :categories

Category.all.each do |category|
  $redis.hset :categories, category.id, category.name
end
