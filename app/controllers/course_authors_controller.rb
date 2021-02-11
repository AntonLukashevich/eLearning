class CourseAuthorsController < ApplicationController
  def new
    @course_author = CourseAuthor.new
  end

  def create
    @course_author = CourseAuthor.new(author_params)

    if @course_author.save
      redirect_to
    else
      render 'new'
    end
  end


  private
  def author_params
    params.require(:course_author).permit(:course_id, :user_id)
  end
end
