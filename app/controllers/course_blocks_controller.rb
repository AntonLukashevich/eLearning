class CourseBlocksController < ApplicationController

  def show
    @course = Course.find(params[:course_id])
    @course_block = @course.course_blocks.find(params[:id])
  end

  def new
    @course = Course.find(params[:course_id])
    @course_block = CourseBlock.new
  end

  def create
    @course = Course.find(params[:course_id])
    @course_block = @course.course_blocks.build(block_params)

    if @course_block.save
      redirect_to @course
    else
      render 'new'
    end
  end

  private

  def block_params
    params.require(:course_block).permit(:title, :description, :type, :order)
  end
end
