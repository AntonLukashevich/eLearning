# frozen_string_literal: true

class AchievementsController < ApplicationController # rubocop:todo Style/Documentation
  def index
    @achievements = Achievement.includes(:course).where(user_id: current_user)
  end

  def certificate
    @achievement = Achievement.includes(:user, :course).find(params[:id])
    if Certificate.where(user_id: @achievement.user.id, course_id: @achievement.course.id,
                         result: @achievement.progress).blank?
      Certificate.create!(user_id: @achievement.user.id, course_id: @achievement.course.id,
                          result: @achievement.progress)
    end
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: " #{current_user.first_name} #{current_user.last_name}, #{Time.zone.now}", # #{@course.title},
               page_size: 'A4',
               template: 'achievements/show.pdf.erb',
               layout: 'pdf.html.erb',
               orientation: 'Portrait',
               lowquality: true,
               zoom: 1,
               dpi: 75
      end
    end
  end

  def new
    @achievement = Achievement.new
  end

  def edit
    @achievement = Achievement.find(params[:id])
  end

  def create
    @user = current_user # User.find(params[:user_id])
    @course = Course.find(params[:course_id])
    @achievement = Achievement.new(achievement_params)

    if @achievement.save
      redirect_to @course
    else
      render 'new'
    end
  end

  def update
    @achievement = Achievement.find(params[:id])
    if @achievement.update(achievement_rating)
      RatingWorker.perform_async(@achievement.id)
      redirect_to achievements_path, success: 'Changes saved.'
    else
      render 'edit', danger: 'Error! Something went wrong... Check your input info.'
    end
  end

  def destroy
    @achievement = Achievement.find(params[:id])
    course = @achievement.course

    destroy_readed(course)
    destroy_responses(course)
    @achievement.destroy

    redirect_to achievements_path, info: 'Achievement deleted.'
  end

  private

  def achievement_params
    params.require(:achievement).permit(:process, :user_id, :course_id, :rating)
  end

  def achievement_rating
    params.require(:achievement).permit(:rating)
  end

  def destroy_readed(course)
    readeds = Readed.where(user_id: current_user.id)
    course.lectures.each do |lec|
      readeds.each do |r|
        r.destroy if r.lecture_id == lec.id
      end
    end
  end

  def destroy_responses(course)
    responses = Response.where(user_id: current_user.id)
    course.testings.each do |t|
      t.questions.each do |q|
        responses.each do |r|
          r.destroy if r.question_id == q.id
        end
      end
    end
  end
end
