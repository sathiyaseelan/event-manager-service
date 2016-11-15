class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request!, only: [:authenticate_user]

  def authenticate_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: payload(user)
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  def unauthenticate
    delete_token(current_user)
  end

  private

  def create_token(user)
    token = JsonWebToken.encode({user_id: user.id.to_s,role: user.role})
    $redis.set(user.id.to_s, token)
    return token
  end

  def delete_token
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
