class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]
  #after_action :add_course_author_to_authors_table, only: :create

  def index
    #binding.pry
    @courses  = Course.eager_load(:course_blocks)
    #binding.pry
  end

  def new
    @course = Course.new
    #@course.build_course_author
    #binding.pry
  end

  def show
  end

  def edit
  end

  def create
    @user = User.find_by(params[:user_id])
    #binding.pry
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
    permitted = params.require(:course).permit(:title, :description,:type_course, :rating, :status, :user_id)
    # course_author_attributes: [user_id: session[:user_id], course_id: :course.id] )
    permitted.merge!(status: "draft" )
  end

  def set_course
    @course= Course.find(params[:id])
  end

  # def add_course_author_to_authors_table
  #   @course_author = CourseAuthor.create(user_id: User.find_by(id: session[:user_id]), course_id: Course.last.id)
  #   #@course_author = CourseAuthor.create(user_id: 4, course_id: Course.last.id)
  #   #binding.pry
  #   @course_author.save
  # end

end

