class TestingsController < ApplicationController
  before_action :set_testing, only: %i[show edit update destroy]

  def index
    @course = Course.find(params[:course_id])
    @testings = @course.testings
  end

  def show
  end

  def new
    @course = Course.find(params[:course_id])
    @testing = Testing.new
  end

  def edit
  end

  def create
    @course = Course.find(params[:course_id])
    @testing = @course.testings.build(testing_params)

    if @testing.save
      redirect_to @course
    else
      render 'new'
    end
    #binding.pry
  end

  def update
    if @testing.update(testing_params)
      redirect_to @course
    else
      render 'edit'
    end
  end

  def destroy
    @testing.destroy
    redirect_to course_path(@course)
  end

  private

  def testing_params
    params.require(:testing).permit(:title, :description, :course_id)
  end

  def set_testing
    @course = Course.find(params[:course_id])
    @testing = @course.testings.find(params[:id])
  end
end
