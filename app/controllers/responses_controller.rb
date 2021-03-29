class ResponsesController < ApplicationController

  def new
    @course = Course.find(params[:course_id])
    @testing = @course.testings.find(params[:testing_id])
    @question = @testing.questions.find(params[:question_id])
    @answers = @question.answers
    @response = Response.new
  end

  def create
    @course = Course.find(params[:course_id])
    @testing = @course.testings.find(params[:testing_id])
    @question = @testing.questions.find(params[:question_id])
    @answers = @question.answers
    @response = @question.responses.build(response_params)

    @response.mark = 0
    #binding.pry
    if @response.save
      current_answers = @question.answers.where(:isCorrect => true).pluck(:answer)
      responses = @question.responses.pluck(:response)
      if (current_answers == responses)
        @response.update(:mark => 1)
      end



      #@responses.each { |r|  }

      binding.pry
      redirect_to course_testing_path(@course,@testing)
    else
      render 'new'
    end
  end


  private

  def response_params
    params.require(:response).permit(:question_id, :response)
  end
end