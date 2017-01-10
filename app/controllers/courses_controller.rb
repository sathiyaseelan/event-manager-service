class CoursesController < ApplicationController

skip_before_action :authenticate_request!, only: [:show, :popular, :index]

  def show
    @course = Course.find(params[:id])
    if @course
      render json: {success: true, course: @course}, status: 200
    else
      render json: {success: false, message: "can not find course"},status: 400
    end
  end

  def popular
    render json: {success: true, courses: Course.popular(params[:limit] || 5) }
  end

  def new
    @course = Course.new(course_params)
    @course.created_by = current_user
    if @course.valid?
      if @course.save
        render json: {success: true},status: 200
      else
        render json: {success: false},status: 500
      end
    else
      render json: {success: true, reason: @course.errors.full_messages},status: 400
    end
  end

  def enrolled
    user = User.find(params[:user_id])
    if user
      enrolled_courses = user.enrolled_courses
      render json: {success: true, courses: enrolled_courses}, status: 200
    else
      render json: {success: false, message: "User not found"}, status: 400
    end
  end

  def created
    user = User.find(params[:user_id])
    if user
      created_courses = user.created_courses
      render json: {success: true, courses: created_courses}, status: 200
    else
      render json: {success: false, message: "User not found"}, status: 400
    end
  end

  def index
    courses = Course.paginated_result(index_params)
    render json: {success: true,courses: courses}, status: 200
  end

  private
  def course_params
    params.permit(Course.fields.keys).except("_id", :created_by_id,:enrolled_user_ids)
  end

end
