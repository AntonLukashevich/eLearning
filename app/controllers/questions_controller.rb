class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy edit]

  def index
    @course = Course.find(params[:course_id])
    @testing = @course.testings.find(params[:testing_id])
    @questions = @testing.questions
  end

  def show

  end

  def new
    @course = Course.find(params[:course_id])
    @testing = @course.testings.find(params[:testing_id])
    @question = Question.new
    #@answer = Answer.new
    @question.answers.build
  end

  def edit

  end

  def create
    @course = Course.find(params[:course_id])
    @testing = @course.testings.find(params[:testing_id])
    @question = @testing.questions.build(question_params)

    #@answer = Answer.new(answer_params)



    if @question.save
      #@answer.question_id = @question.id
      # @answer.save!
      redirect_to course_testing_path(@course, @testing)
    else
      render 'new'
    end
  end

  def update
    if @question.update(question_params)
      redirect_to course_testing_path(@course,@testing)
    else
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    redirect_to course_testing_path(@course,@testing)
  end

  private

  def question_params
    params.require(:question).permit(:question, :type, :testing_id, :content, answers_attributes: Answer.attribute_names.map(&:to_sym).push(:_destroy) )
  end

  def answer_params
    params.require(:answer).permit(:answer, :isCorrect, :position, :question_id)
  end

  def set_question
    @course = Course.find(params[:course_id])
    @testing = @course.testings.find(params[:testing_id])
    @question = @testing.questions.find(params[:id])
  end
end
