class ActivitiesController < ApplicationController

  def show
    @activity = Activity.find(params[:id])
    if @activity
      render json: @activity, status: :success
    else
      render json: {message: "can not find activity"},status: 400
    end
  end

  def upcoming
    render json: Activity.upcoming(params[:limit] || 5)
  end

  def new
    @activity = Activity.new(activity_params)
    @activity.created_by = current_user
    if @activity.valid?
      if @activity.save
        render json: {message: :success},status: 200
      else
        render json: {message: :failed},status: 500
      end
    else
      render json: {message: :failed, reason: @activity.errors.full_messages},status: 400
    end
  end

  def enrolled_activities
    user = User.find(params[:user_id])
    if user
      enrolled_activities = user.enrolled_activities
      render json: enrolled_activities, status: :success
    else
      render json: {message: "User not found"}, status: 400
    end
  end

  def created_activities
    user = User.find(params[:user_id])
    respond_to do |format|
      if user
        created_activities = user.created_activities
      format.json{  render json: created_activities, status: :success}
      else
    format.json{  render json: {message: "User not found"}, status: 400 }
      end
    end
  end

  def index
    activities = Activity.paginated_result(index_params)
    render json: activities, status: 200
  end


  private
  def activity_params
    params.permit(Activity.fields.keys).except("_id", :created_by_id,:enrolled_user_ids)
  end

end
