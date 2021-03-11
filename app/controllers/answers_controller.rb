class AnswersController < ApplicationController

  def show
    @answer = Answer.find(params[:id])
  end

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.create(answer_params)
    respond_to do |format|

      if @answer.save
        format.js
        redirect_to @answer
      else
        render 'new'
      end
    end
  end

  private

  def answer_params
    params.require(:question).permit(:answer, :isCorrect, :position, :question_id)
  end
end
