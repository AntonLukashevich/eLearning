# frozen_string_literal: true

class TestingsController < ApplicationController # rubocop:todo Style/Documentation
  before_action :set_testing, only: %i[show edit update destroy]
  before_action :set_course, only: %i[index new create]

  def index
    @testings = @course.testings
  end

  def show
    @responses = Response.all.where(user_id: @user.id)
  end

  def new
    @testing = Testing.new
  end

  def edit; end

  def create
    @testing = @course.testings.build(testing_params)
    if @testing.save
      redirect_to @course
    else
      render 'new'
    end
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

  def pass_testing
    @course = Course.find(params[:course_id])
    @testing = @course.testings.find(params[:id])
    @questions = @testing.questions.includes(:answers).paginate(page: params[:page], per_page: 1)
  end

  private

  def testing_params
    params.require(:testing).permit(:title, :description, :course_id)
  end

  def set_testing
    @user = current_user
    set_course
    @testing = @course.testings.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end
end
