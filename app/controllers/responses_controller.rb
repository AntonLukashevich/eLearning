# frozen_string_literal: true

class ResponsesController < ApplicationController # rubocop:todo Style/Documentation
  def new
    set_course
    set_testing(@course)
    set_question(@testing)
    set_answers(@question)
    @response = Response.new
  end

  def create
    @user = current_user
    set_course
    set_testing(@course)
    set_question(@testing)
    set_answers(@question)
    params[:response].each do |r|
      Response.create(response: r, mark: 0, user_id: @user.id, question_id: @question.id)
    end

    current_answers = @question.answers.where(isCorrect: true).pluck(:answer)
    responses = @question.responses.pluck(:response)
    @question.responses.update_all(mark: 1) if current_answers == responses # rubocop:todo Rails/SkipsModelValidations
    flash.now[:info] = 'Your answer saved'
    # redirect_to course_testing_path(@course, @testing)
  end

  private

  def response_params
    params.require(:response).permit(:question_id, :user_id, :response)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_testing(course)
    @testing = course.testings.find(params[:testing_id])
  end

  def set_question(testing)
    @question = testing.questions.find(params[:question_id])
  end

  def set_answers(question)
    @answers = question.answers
  end
end
