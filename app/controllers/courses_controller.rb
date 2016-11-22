class CoursesController < ApplicationController

  def show
    @course = Course.find(params[:id])
    if @course
      render json: @course, status: :success
    else
      render json: {message: "can not find course"},status: 400
    end
  end

  def popular
    render json: Course.popular(params[:limit] || 5)
  end

  def new
    @course = Course.new(course_params)
    @course.created_by = current_user
    if @course.valid?
      if @course.save
        render json: {message: :success},status: 200
      else
        render json: {message: :failed},status: 500
      end
    else
      render json: {message: :failed, reason: @course.errors.full_messages},status: 400
    end
  end

  def enrolled_courses
    user = User.find(params[:user_id])
    if user
      enrolled_courses = user.enrolled_courses
      render json: enrolled_courses, status: :success
    else
      render json: {message: "User not found"}, status: 400
    end
  end

  def created_courses
    user = User.find(params[:user_id])
    if user
      created_courses = user.created_courses
      render json: created_courses, status: :success
    else
      render json: {message: "User not found"}, status: 400
    end
  end

  def index
    courses = Course.paginated_result(index_params)
    render json: courses, status: 200
  end

  private
  def course_params
    params.permit(Course.fields.keys).except("_id", :created_by_id,:enrolled_user_ids)
  end

end
