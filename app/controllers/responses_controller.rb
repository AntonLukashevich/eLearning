class ResponsesController < ApplicationController

  def new
    @course = Course.find(params[:course_id])
    @testing = @course.testings.find(params[:testing_id])
    @question = @testing.questions.find(params[:question_id])
    @answers = @question.answers
    @response = Response.new
  end

  def create
    @user = current_user
    @course = Course.find(params[:course_id])
    @testing = @course.testings.find(params[:testing_id])
    @question = @testing.questions.find(params[:question_id])
    @answers = @question.answers

    params[:response].each do | r |
      Response.create(:response => r, :mark => 0, :user_id => @user.id, question_id: @question.id)
    end

    current_answers = @question.answers.where(:isCorrect => true).pluck(:answer)
    responses = @question.responses.pluck(:response)
    if (current_answers == responses)
      @question.responses.update_all(:mark => 1)
    end
    redirect_to course_testing_path(@course,@testing)

  end


  private

  def response_params
    params.require(:response).permit( :question_id,  :user_id, :response)
  end

end
