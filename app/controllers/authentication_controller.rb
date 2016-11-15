class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request!, only: [:authenticate]

  def authenticate
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: payload(user)
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  def unauthenticate
    delete_token(current_user)
    render json: { message: 'success'}, status: :success
  end


end
