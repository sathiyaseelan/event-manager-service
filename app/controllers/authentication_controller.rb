class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request!, only: [:authenticate]

  def authenticate
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: {success: true,user: payload(user)}
    else
      render json: {success: false, errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  def unauthenticate
    delete_token(current_user)
    render json: { success: true}, status: 200
  end

end
