class ActivitiesController < ApplicationController
  skip_before_action :authenticate_request!, only: [:show, :upcoming, :index]

  def show
    @activity = Activity.find(params[:id])
    if @activity
      render json:{success: true, activity: @activity}, status: 200
    else
      render json: {success: false, message: "can not find activity"},status: 400
    end
  end

  def upcoming
    render json: {success: true, activities: Activity.upcoming(params[:limit] || 5) }
  end

  def new
    @activity = Activity.new(activity_params)
    @activity.created_by = current_user
    if @activity.valid?
      if @activity.save
        render json: {success: true,message: :success},status: 200
      else
        render json: {success: false,message: :failed},status: 500
      end
    else
      render json: {success: false,message: :failed, reason: @activity.errors.full_messages},status: 400
    end
  end

  def enrolled
    user = User.find(params[:user_id])
    if user
      enrolled_activities = user.enrolled_activities
      render json: {success: true, enrolled_activities: enrolled_activities}, status: 200
    else
      render json: {success: false, message: "User not found"}, status: 400
    end
  end

  def created
    user = User.find(params[:user_id])
    if user
      created_activities = user.created_activities
      render json: {success: true,created_activities: created_activities}, status: 200
    else
      render json: {success: false, message: "User not found"}, status: 400
    end
  end

  def index
    activities = Activity.paginated_result(index_params)
    render json:{success: true, activities: activities}, status: 200
  end


  private
  def activity_params
    params.permit(Activity.fields.keys).except("_id", :created_by_id,:enrolled_user_ids)
  end

end
