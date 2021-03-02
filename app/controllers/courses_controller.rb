class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]

  def index

    @courses  = Course.eager_load(:course_blocks)

  end

  def new
    @course = Course.new
  end

  def show
    #@authors = Course.includes(:users).find(:course_id)
    @course_blocks = @course.lectures
    respond_to do |format|
      format.html
      format.js
      format.json {render :json => @course.to_json}
    end
  end

  def edit
  end

  def create
    @user = User.find_by(params[:user_id])
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

  private
  def course_params
    permitted = params.require(:course).permit(:title, :description,:type_course, :rating, :status, :user_id, :image)
    permitted.merge!(status: "draft" )
  end

  def set_course
    @course= Course.find(params[:id])
  end
end

