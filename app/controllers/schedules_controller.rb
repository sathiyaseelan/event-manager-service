class SchedulesController < ApplicationController

  def new
    if params[:type]
      render json: {success: false, message: 'Missing type parameter'}
    end
  end

  def show
  end

end
