class RadioQuestionsController < ApplicationController
  def new
    #binding.pry
    @course = Course.find(params[:course_id])
    @testing = @course.testings.find(params[:testing_id])
    @question = RadioQuestion.new
    @question.answers.new
  end

  def create
    @course = Course.find(params[:course_id])
    @testing = @course.testings.find(params[:testing_id])
    @question = @testing.radio_questions.build(question_params)

    if @question.save
      redirect_to course_testing_path(@course, @testing)
    else
      render 'new'
    end
  end

  private

  def question_params
    params.require(params[:type].try(:downcase) || :question).permit(:question, :type, :testing_id, answers_attributes: [:answer, :isCorrect, :position, :question_id])
  end
end
