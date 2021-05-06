class OrgCoursesController < ApplicationController
  def index
    @course = Course.find(params[:course_id])
    @org_courses = OrgCourse.where(course_id: @course.id)
  end

  def new
    @course = Course.find(params[:course_id])
    @org_course = OrgCourse.new
  end

  def create
    @course = Course.find(params[:course_id])
    @org_course = @course.org_courses.build(org_course_params)
    respond_to do |format|
      if @org_course.save
        format.js
        format.html{redirect_to course_org_courses_path(@course), success: 'The course added to organization'}
        format.json
      end
    end
  end

  def destroy
    @course = Course.find(params[:course_id])
    @org_course = OrgCourse.find(params[:id])
    @org_course.destroy

    respond_to do |format|
      format.js
      format.html{ redirect_to course_org_courses_path(@course),  info: 'The organization removed!'}
      format.json
    end
  end


  private

  def org_course_params
    params.require(:org_course).permit(:organization_id)
  end
end
