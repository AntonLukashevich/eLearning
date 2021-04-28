# frozen_string_literal: true

class TestingsController < ApplicationController # rubocop:todo Style/Documentation
  before_action :set_testing, only: %i[show edit update destroy]
  before_action :set_course, only: %i[index new create]
  before_action :authenticate_user!

  def index
    @testings = @course.testings
  end

  def show
    @responses = Response.where(user_id: @user.id)

  end

  def new
    @testing = Testing.new
  end

  def edit; end

  def create
    @testing = @course.testings.build(testing_params)
    if @testing.save
      redirect_to @course, success: 'The test saved!'
    else
      render 'new', danger: 'Error! Check input info...'
    end
  end

  def update
    if @testing.update(testing_params)
      redirect_to @course, success: 'Changes saved!'
    else
      render 'edit', danger: 'Error! Check input info...'
    end
  end

  def destroy
    @testing.destroy
    respond_to do |format|
      format.js
      redirect_to course_path(@course), info: 'The test deleted.'
      format.json
    end
  end

  def pass_testing
    @course = Course.find(params[:course_id])
    @testing = @course.testings.find(params[:id])
    @questions = @testing.questions.includes(:answers).paginate(page: params[:page], per_page: 1)
  end

  def retake
    @course = Course.find(params[:course_id])
    @testing = @course.testings.find(params[:id])

    @testing.questions.each do |q|
      q.responses.each do |r|
        if r.user_id == current_user.id && r.present?
          r.destroy
        end
      end
    end

    redirect_to pass_testing_course_testing_path(@course, @testing)
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

  def test_result
    set_testing
    questions = @testing.questions
    result = 0

    questions.each do |q|
      @responses.each do |r|
        if (q.id == r.question_id && r.mark == 1)
          result +=1
        end
      end
    end
    return result
  end

end
