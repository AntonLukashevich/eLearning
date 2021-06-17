# frozen_string_literal: true

class OrgCoursesController < ApplicationController
  before_action :set_course, only: %i[index new create destroy]
  def index
    @org_courses = OrgCourse.where(course_id: @course.id)
  end

  def new
    @org_course = OrgCourse.new
  end

  def create
    @org_course = @course.org_courses.build(org_course_params)
    respond_to do |format|
      if @org_course.save
        format.js
        format.html { redirect_to course_org_courses_path(@course), success: 'The course added to organization' }
        format.json
      end
    end
  end

  def destroy
    @org_course = OrgCourse.find(params[:id])
    @org_course.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to course_org_courses_path(@course), info: 'The organization removed!' }
      format.json
    end
  end

  private

  def org_course_params
    params.require(:org_course).permit(:organization_id)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end
end
