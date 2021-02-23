class LecturesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]

  def index
    @course = Course.find(params[:course_id])
    @course_block = @course.course_blocks.find(params[:course_block_id])
    @lectures = @course_block.lecture
  end

  def new
    @course = Course.find(params[:course_id])
    @course_block = @course.course_blocks.find(params[:course_block_id])
    @lecture = Lecture.new
  end

  def show
  end

  def edit
  end

  def create

    @course = Course.find(params[:course_id])
    @course_block = @course.course_blocks.find(params[:course_block_id])
    binding.pry
    @lecture = @course_block.lectures.build(lecture_params)

    if @lecture.save
      redirect_to @course
    else
      render 'new'
    end
  end

  def update
    if @lecture.update(lecture_params)
      redirect_to @lecture
    else
      render 'edit'
    end
  end

  def destroy
    @lecture.destroy
    redirect_to users_path
  end

  private

  def lecture_params
    params.require(:lecture).permit(:title, :description, :course_block_id )
  end

  def set_lecture
    @lecture = Lecture.find(params[:id])
  end
end
