class ApplicationController < ActionController::Base
  include AuthenticationHelper
  include ApplicationHelper
  protect_from_forgery with: :null_session
  before_action :authenticate_request!

  # Temporary fix for allowing all domain
  before_filter :set_cross_domain_headers

  attr_reader :current_user

  protected
  def authenticate_request!

    unless user_id_in_token?
      render json: {success: false, errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    if logged_in?(auth_token["user_id"])
      @current_user = User.find(auth_token["user_id"])
    else
      render json: {success: false, errors: ['Session invalid'] }, status: :unauthorized
    end
  rescue JWT::VerificationError, JWT::DecodeError
    render json: {success: false, errors: ['Not Authenticated'] }, status: :unauthorized
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


  def set_cross_domain_headers
    response.headers['Access-Control-Allow-Origin'] = "*"
    response.headers['Access-Control-Allow-Methods'] = "GET, POST, PUT, DELETE, OPTIONS"
  end
end
