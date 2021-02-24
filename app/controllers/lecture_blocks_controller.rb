class LectureBlocksController < ApplicationController
  before_action :set_lecture_block, only: %i[show, edit, update, destroy]
  def index

  end

  def new
    #binding.pry
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:lecture_id])

    @lecture_block = LectureBlock.new
  end

  def show

  end

  def edit

  end

  def create
    binding.pry
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:lecture_id])
    @lecture_block = @lecture.lecture_blocks.build(block_params)

    if @lecture_block.save
      redirect_to @lecture
    else
      render 'new'
    end
  end

  private

  def block_params
    #:course_block_id = params[:lecture_id]
    binding.pry

    a = params.require(:lecture_block).permit(:title, :content, :lecture_id).to_h.tap do |n|
      binding.pry
      n["course_block_id"] = params["lecture_id"]
      #n.except!(:lecture_id)
    end
    binding.pry
  end

  def set_lecture_block
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:lecture_id])

    @lecture_block = @lecture.lecture_blocks.find(params[:id])
  end
end
