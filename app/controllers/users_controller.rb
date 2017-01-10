class UsersController < ApplicationController

  def index
    render json: User.all
  end

  def create
    @user = User.new(user_params)
    if @user.valid? && @user.save
      render json: {success: true}, status: 200
    else
      render json: {success: false, message: @user.errors.full_messages}, status: 500
    end
  end

  def update_role
    if current_user.is_super_user?
      user_to_be_updated = User.find(params[:user_id])
      user_to_be_updated.role = params[:new_role]
      if user_to_be_updated.save
        delete_token(user_to_be_updated)
        render json: {success: true}, status: success
      else
        render json: {success: false},status: 500
      end
    else
      render json: {success: false, message: "Not authorized"}, status: :unauthorized
    end
  end

  def update
    message = []
    status = true
    if params[:new_email]
      current_user.email = params[:email]
      if current_user.save
        message << 'Email updated.Login Again'
        delete_token(current_user)
      end
    end
    if params[:new_password]
      if current_user.authenticate(params[:old_password])
        current_user.password = params[:new_password]
        if current_user.save
          message << 'Password updated. Login Again'
          delete_token(current_user)
        end
      else
        status = false
        message << 'Password Incorrect'
      end
    end
    render json: { success: status, message: message }
  end

  private
  def user_params
    paras.permit(:email,:first_name,:last_name,:password)
  end
end
