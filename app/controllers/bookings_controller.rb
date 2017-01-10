class BookingsController < ApplicationController

  def create
    @booking = Booking.new(booking_params)
    @booking.created_by = current_user
    if @booking.valid? && @booking.save
      render json: { success: true, message: "saved successfully" }, status: 200
    else
      render json: { success: false, message: @booking.errors.full_messages },status: 500
    end
  end

  def update
  end

  def show
    if params[:id]
      @booking = Booking.find(params[:id])
      if @booking
        render json: {success: true, booking: @booking}, status: 200
      else
        render json: {success: false, message: "can not find booking"},status: 400
      end
    else
      render json: {success: false, message: "parameter id missing"},status: 400
    end
  end

  def index
    render json: {success: true, bookings: Booking.all}
  end

  def delete
    if params[:id]
      @booking = Booking.find(params[:id])
      if @booking && @booking.destroy
        render json: {success: true, message: "successfully deleted the booking"}, status: 200
      else
        render json: {success: false, message: "can not find booking"},status: 400
      end
    else
      render json: {success: false, message: "parameter id missing"},status: 400
    end
  end

  private

  def booking_params
    params.permit(Booking.fields.keys).except("_id", :created_by_id)
  end

end
