class UsersController < ApplicationController

  def index
    render json: User.all
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
