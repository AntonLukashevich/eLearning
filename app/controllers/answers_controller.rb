class AnswersController < ApplicationController
  def index
    @answers = Answer.all
  end

  def show

  end

  def new
    @answer = Answer.new
  end

  def edit
    @answer = Answer.find(params[:id])
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

  def update
    if @answer.update(answer_params)
      redirect_to @answer
    else
      render 'edit'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    #redirect_to
  end

  private

  def answer_params
    params.require(:question).permit(:answer, :isCorrect, :position, :question_id)
  end
end
