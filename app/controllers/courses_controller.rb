class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def show
  end

  def edit
  end

  def create
    @user = current_user # User.find(params[:user_id])
    @course = @user.courses.create(course_params)

    if @course.save
      redirect_to @course
    else
      render 'new'
    end
  end

  def update
    if @course.update(course_params)
      redirect_to @course
    else
      render 'edit'
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path
  end

  def to_publish
    @course = Course.find(params[:id])
    @course.update(:status => 'ready')
    redirect_to user_path(current_user)
  end

  private

  def course_params
    permitted = params.require(:course).permit(:title, :description, :type_course, :rating, :status, :user_id, :image)
    permitted.merge!(status: "draft")
  end

  def set_course
    @course = Course.find(params[:id])
  end
end

