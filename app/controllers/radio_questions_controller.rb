class RadioQuestionsController < ApplicationController
  def new
    #binding.pry
    @course = Course.find(params[:course_id])
    @course_test = @course.course_tests.find(params[:course_test_id])
    @question = RadioQuestion.new
    @question.answers.new
  end

  def create
    @course = Course.find(params[:course_id])
    @course_test = @course.course_tests.find(params[:course_test_id])
    @question = @course_test.radio_questions.build(block_params)

    if @question.save
      redirect_to course_course_test_path(@course, @course_test)
    else
      render 'new'
    end
  end

  private

  def question_params
    params.require(params[:type].try(:downcase) || :question).permit(:question, :course_test_id, answer_attributes: [:answer, :isCorrect])
  end
end
