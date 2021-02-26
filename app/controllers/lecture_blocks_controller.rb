class LectureBlocksController < ApplicationController
  before_action :set_lecture_block, only: %i[show edit update destroy]
  def index

  end

  def new
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:lecture_id])
    @lecture_block = LectureBlock.new
  end

  def show
  end

  def edit

  end

  def create
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:lecture_id])
    @lecture_block = @lecture.lecture_blocks.build(block_params)

    if @lecture_block.save
      redirect_to course_lecture_path(@course, @lecture)
    else
      render 'new'
    end
  end

  def update
    if @lecture_block.update(block_params)
      redirect_to course_lecture_path(@course, @lecture)
    else
      render 'edit'
    end
  end

  private

  def block_params
   params.require(:lecture_block).permit(:title, :content, :lecture_id) #.to_h.tap do |n|
      # binding.pry
    #n["course_block_id"] = params["lecture_id"]
       #n.except!(:lecture_id)
    #end
    #binding.pry
  end

  def set_lecture_block
    @course = Course.find(params["course_id"])
    @lecture = @course.lectures.find(params["lecture_id"])
    @lecture_block = @lecture.lecture_blocks.find(params["id"])
  end
end
