# frozen_string_literal: true

class QuestionsController < ApplicationController # rubocop:todo Style/Documentation
  before_action :set_question, only: %i[show edit update destroy edit]
  before_action :set_course_testing, only: %i[index new create]

  def index
    @questions = @testing.questions
  end

  def show; end

  def new
    @question = Question.new
    @question.answers.build
  end

  def edit; end

  def create
    @question = @testing.questions.build(question_params)
    if @question.save
      redirect_to course_testing_path(@course, @testing), success: 'Question saved!'
    else
      render 'new', danger: 'Error! Check input info...'
    end
  end

  def update
    if @question.update(question_params)
      redirect_to course_testing_path(@course, @testing), success: 'Changes saved!'
    else
      render 'edit', danger: 'Error! Check input info...'
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.js
      redirect_to course_testing_path(@course, @testing), info: 'The question deleted.'
      format.json
    end
  end

  private

  def question_params
    params.require(:question).permit(:question, :type_question, :testing_id, :content,
                                     answers_attributes: Answer.attribute_names.map(&:to_sym).push(:_destroy))
  end

  def answer_params
    params.require(:answer).permit(:answer, :isCorrect, :position, :question_id)
  end

  def set_question
    set_course_testing
    @question = @testing.questions.find(params[:id])
  end

  def set_course_testing
    @course = Course.find(params[:course_id])
    @testing = @course.testings.find(params[:testing_id])
  end
end
