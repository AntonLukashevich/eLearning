class LecturesController < ApplicationController
  before_action :set_lecture, only: %i[show edit update destroy move]

  def index
    @course = Course.find(params[:course_id])
    @lectures = @course.lectures.where(type: "Lecture")
  end

  def new
    @course = Course.find(params[:course_id])
    @lecture = Lecture.new
  end

  def show
  end

  def edit
  end

  def create
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.build(lecture_params)

    if @lecture.save
      redirect_to @course
    else
      render 'new'
    end
  end

  def update
    if @lecture.update(lecture_params)
      redirect_to @course
    else
      render 'edit'
    end
  end

  def destroy
    @lecture.destroy
    redirect_to users_path
  end

  def move
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:id])
    @lecture.insert_at(params[:position].to_i)
    head :ok
  end
  private

  def lecture_params
    params.require(:lecture).permit(:title, :description, :content)
  end

  def set_lecture
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:id])
  end
end
