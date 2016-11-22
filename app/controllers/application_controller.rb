class ApplicationController < ActionController::Base
  include AuthenticationHelper
  include ApplicationHelper
  protect_from_forgery with: :null_session
  before_action :authenticate_request!

  attr_reader :current_user

  protected
  def authenticate_request!

    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    if logged_in?(auth_token["user_id"])
      @current_user = User.find(auth_token["user_id"])
    else
      render json: { errors: ['Session invalid'] }, status: :unauthorized
    end
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  private

  def logged_in?(user_id)
      $redis.get(user_id) != nil
  end

  def http_token
      @http_token ||= if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end
end
