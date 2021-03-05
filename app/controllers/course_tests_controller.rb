class CourseTestsController < ApplicationController
  before_action :set_test, only: %i[show update destroy edit]

  def index
    @course = Course.find(params[:course_id])
    @course_test = @course.course_blocks.where(type: "CourseTest")
  end

  def new
    @course = Course.find(params[:course_id])
    @course_test = CourseTest.new
  end

  def show
  end

  def edit
  end

  def create

    @course = Course.find(params[:course_id])
    @course_test = @course.course_blocks.build(test_params)

    if @course_test.save
      redirect_to @course
    else
      render 'new'
    end
  end

  private

  def set_test
    #binding.pry
    @course = Course.find(params[:course_id])
    @course_test = @course.course_blocks.find(params[:id])
  end

  def test_params
    params.require(:course_test).permit(:title, :description)
  end

end
