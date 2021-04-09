# frozen_string_literal: true

class LecturesController < ApplicationController # rubocop:todo Style/Documentation
  before_action :set_lecture, only: %i[show edit update destroy move readed]
  before_action :set_course, only: %i[index new create]
  before_action :authenticate_user!

  def index
    @lectures = @course.lectures
  end

  def new
    @lecture = Lecture.new
  end

  def show
    @readed = Readed.where(lecture_id: @lecture.id, user_id: current_user.id).first
  end

  def edit; end

  def create
    @lecture = @course.lectures.build(lecture_params)
    if @lecture.save
      redirect_to @course, success: 'The lecture saved!'
    else
      render 'new', danger: 'Error! Check input info...'
    end
  end

  def update
    if @lecture.update(lecture_params)
      redirect_to @course, success: 'Changes saved!'
    else
      render 'edit', danger: 'Error! Check input info...'
    end
  end

  def destroy
    @lecture.destroy
    redirect_to course_path(@course), info: 'The lecture deleted.'
  end

  def move
    @lecture.insert_at(params[:position].to_i)
    head :ok # ???
  end

  def readed
    @user = current_user
    @lecture.readeds.create(lecture_id: @lecture.id, user_id: @user.id, is_readed: true)
    redirect_to @course
  end

  def readed?
    @user = current_user
    @readed = Readed.where(lecture_id: @lecture, user_id: @user.id).first
    @readed.is_readed
  end

  private

  def lecture_params
    params.require(:lecture).permit(:title, :description, :content)

    # .to_h.tap do |n|
    # binding.pry
    # n["course_block_id"] = params["lecture_id"]
    # n.except!(:lecture_id)
    # end
    # binding.pry
  end

  def set_lecture
    @course = set_course
    @lecture = @course.lectures.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end
end
