module AuthenticationHelper

  def create_token(user)
    token = JsonWebToken.encode({user_id: user.id.to_s,role: user.role})
    $redis.set(user.id.to_s, token)
    return token
  end

  def delete_token(user)
    $redis.del(user.id.to_s)
  end

  def payload(user)
    return nil unless user and user.id
    {
      token: create_token(user),
      user: {id: user.id.to_s, email: user.email, role: user.role, status: user.status, first_name: user.first_name, last_name: user.last_name, contact: user.contact}
    }
  end

end
