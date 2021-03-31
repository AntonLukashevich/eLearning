# frozen_string_literal: true

class AnswersController < ApplicationController # rubocop:todo Style/Documentation
  before_action :set_answer, only: %i[show edit update destroy]
  def index
    @answers = Answer.all
  end

  def show; end

  def new
    @answer = Answer.new
  end

  def edit; end

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
    @answer.destroy
  end

  private

  def answer_params
    params.require(:answer).permit(:answer, :isCorrect, :position, :question_id)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
