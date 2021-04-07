# frozen_string_literal: true

class CoursesController < ApplicationController # rubocop:todo Style/Documentation
  before_action :set_course, only: %i[show edit update destroy to_publish subscribe unsubscribe]
  before_action :set_user, only: %i[show create subscribe unsubscribe]

  def index
    @courses = Course.includes(:users, :achievements).where(status: 'ready').by_created_at
  end

  def new
    @course = Course.new
  end

  def show
    @readeds = Readed.where(user_id: @user.id)
  end

  def edit; end

  def create
    @course = @user.courses.create(course_params)

    if @course.save
      redirect_to @course, success: 'The course created!-*'
    else
      render 'new', danger: 'Error! Something went wrong... Check your input info.'
    end
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
    @course.update(status: 'ready')
    redirect_to user_path(current_user), success: 'The course published.'
  end

  def subscribe
    if subscribed?(@user.id, @course.id)
      redirect_to @course
    else
      @achievement = @course.achievements.create(user_id: @user.id, course_id: @course.id, :progress => 0)
      @achievement.save
      redirect_to achievements_path,  success: 'Subscribed! New achievement is open.'
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

  private

  def course_params
    permitted = params.require(:course).permit(:title, :description, :type_course, :rating, :status, :user_id, :image)
    permitted.merge!(status: 'draft')
  end

  def set_course
    @course = Course.includes( :testings, :users).find(params[:id])
  end

  def set_user
    @user = current_user
  end
end
