# frozen_string_literal: true

class CoursesController < ApplicationController # rubocop:todo Style/Documentation
  load_and_authorize_resource
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_course, only: %i[show edit update destroy to_publish subscribe unsubscribe]
  before_action :set_user, only: %i[show create subscribe unsubscribe]

  def index
    @started_courses = Achievement.includes(:user, :course).where(user_id: current_user).order(progress: :asc).limit(4)
    @new_courses = Course.includes(:users).where(status: 'ready').by_last_created_at.limit(5)
    @rating_courses = Course.where(status: 'ready').order(rating: :desc).limit(5)
    @org_courses = Course.where(status: 'ready', type_course: 'private').limit(3)
  end

  def new
    @course = Course.new
  end

  def show
    @readeds = Readed.where(user_id: @user.id) if user_signed_in?
  end

  def edit; end

  def create
    @course = @user.courses.create(course_params)
    if @course.save
      redirect_to my_courses_courses_path, success: 'The course created!'
    else
      render 'new', danger: 'Error! Something went wrong... Check your input info.'
    end
  end

  def my_courses
    @user ||= current_user
    @courses = @user.courses.includes(:lectures, :testings).order(params[:sort])
  end

  def update
    if @course.update(course_params)
      redirect_to @course, success: 'Changes saved.'
    else
      render 'edit', danger: 'Error! Something went wrong... Check your input info.'
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path, info: 'The course deleted!'
  end

  def to_publish
    AddCourseToPublicationWorker.perform_async(@course.id)
    redirect_to courses_admins_path, info: 'The course will be publish soon'
  end

  def request_to
    RequestToPublishCourseWorker.perform_async(@course.id)
    # @course.update(status: 'ready')
    redirect_to my_courses_courses_path, info: 'The request has been sen. Wait for an answer...'
  end

  def to_draft
    NayToPublicationCourseWorker.perform_async(@course.id)
    # @course.update(status: 'draft')
    redirect_to courses_admins_path, info: 'The request rejected.'
  end

  def subscribe
    if subscribed?(@user.id, @course.id)
      redirect_to @course
    else
      @achievement = @course.achievements.create(user_id: @user.id, course_id: @course.id, progress: 0)
      @achievement.save
      redirect_to achievements_path, success: 'Subscribed! New achievement is open.'
    end
  end

  def unsubscribe
    @achievement = @course.achievements.where(user_id: @user.id, course_id: @course.id)
    @achievement.destroy
    redirect_to achievements_path, info: 'Unsubscribed!'
  end

  def subscribed?(user, course)
    Achievement.where(user_id: user, course_id: course).exists?
  end

  def authors
    # @users = User.all - @course.users
    if params[:search]
      @search_term = params[:search]
      @users = User.search_by(@search_term)
    else
      @users = User.all - @course.users
    end
  end

  def new_author
    @course = Course.find(params[:id])
    @user = User.find(params[:user_id])
    @course.users << @user
    redirect_to authors_course_path(@course)
  end

  def delete_author
    @course = Course.find(params[:id])
    @user = User.find(params[:user_id])
    @course.users.delete(@user)
    redirect_to authors_course_path(@course)
  end

  def publications
    if params[:search]
      @search_term = params[:search]
      @courses = @courses.search_by(@search_term)
    else
      @courses = Course.includes(:users, :achievements).where(status: 'ready').by_last_created_at
    end
  end

  private

  def course_params
    permitted = params.require(:course).permit(:title, :description, :type_course, :rating, :status, :user_id, :image)
    permitted.merge!(status: 'draft', rating: 0)
  end

  def set_course
    @course = Course.includes(:testings, :users).find(params[:id])
  end

  def set_user
    @user = current_user
  end
end
