class SearchSuggestion

  def self.emails_for(prefix)
    $redis.zrevrange "search-suggestions:#{prefix.downcase}",0 , 9
  end

  def self.seed_emails_to_redis
    User.all.each do |user|
      email = user.email
      add_email_to_redis(email)
    end
  end

  def self.seed_update(email)
    add_email_to_redis(email.downcase)
  end

  def self.clear_emails
    keys = $redis.keys "search-suggestions:*"
    unless keys.empty?
      count = $redis.del keys
      puts "Total number of keys cleared:#{count}"
    end
  end

  private
  def self.add_email_to_redis(email)
    if email && !email.empty?
      3.upto(email.length-1) do |c|
        prefix = email[0, c]
        $redis.zadd "search-suggestions:#{prefix}", 1, email
      end
    end
  end
end
