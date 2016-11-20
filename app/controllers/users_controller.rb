class UsersController < ApplicationController

  def index
    render json: User.all
  end

  def update_role
    if current_user.is_super_user?
      user_to_be_updated = User.find(params[:user_id])
      user_to_be_updated.role = params[:new_role]
      if user_to_be_updated.save
        delete_token(user_to_be_updated)
        render json: {message: "success"}, status: success
      else
        render json: {message: "failed"},status: 500
      end
    else
      render json: {message: "Not authorized"}, status: :unauthorized
    end
  end

  def update
    message = []
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
        message << 'Password Incorrect'
      end
    end
    render json: { message: message }
  end

  private
  def login_params
    params.require(:user).permit(:user_id, :password)
  end


end
