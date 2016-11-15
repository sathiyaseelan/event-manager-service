class UsersController < ApplicationController

  def index
    render json: User.all
  end

  def update
    message = []
    if params[:new_email]
      current_user.email = params[:email]
      message << 'Email updated'
    end
    if params[:new_password]
      if params[:old_password] == user.password
        current_user.password = params[:new_password]
        message << 'New Password updated'
      else
        message << 'Password Incorrect'
      end
    end
  end

  private
  def login_params
    params.require(:user).permit(:user_id, :password)
  end


end
