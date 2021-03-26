class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy to_publish]

  def index
    @courses = Course.all.where(status: 'ready')
  end

  def new
    @course = Course.new
  end

  def show
    @user = current_user
    @readeds = Readed.all.where(:user_id => @user.id)
  end

  def edit
  end

  def create
    @user = current_user # User.find(params[:user_id])
    @course = @user.courses.create(course_params)

    if @course.save
      redirect_to @course
    else
      render 'new'
    end
  end

  def update
    if @course.update(course_params)
      redirect_to @course
    else
      render 'edit'
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path
  end

  def to_publish
    @course.update(:status => 'ready')
    redirect_to user_path(current_user)
  end

  def subscribe
    @course = Course.find(params[:id])
    @user = current_user

    if is_subscribed?(@user.id, @course.id)
      redirect_to @course
    else
      @achievement = @course.achievements.create( :user_id => @user.id, :course_id => @course.id, :progress => 0,)
      @achievement.save
      redirect_to achievements_path
    end
  end

  def unsubscribe
    @course = Course.find(params[:id])
    @user = current_user
    @achievement = @course.achievements.where(:user_id => @user.id, :course_id => @course.id)
    binding.pry
    @achievement.destroy
    redirect_to achievements_path
  end

  def is_subscribed?(user, course)
    Achievement.where(:user_id => user, :course_id => course).exists?
  end

  private

  def course_params
    permitted = params.require(:course).permit(:title, :description, :type_course, :rating, :status, :user_id, :image)
    permitted.merge!(status: "draft")
  end

  def set_course
    @course = Course.find(params[:id])
  end


end

