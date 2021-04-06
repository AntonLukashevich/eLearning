# frozen_string_literal: true

class AchievementsController < ApplicationController # rubocop:todo Style/Documentation
  def index
    @achievements = Achievement.includes(:user, :course).where(user_id: current_user)
  end

  def new
    @achievement = Achievement.new
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
    params.require(:achievement).permit(:process, :user_id, :course_id)
  end

  def destroy_readed(course)
    readeds = Readed.where(user_id: current_user.id)
    course.lectures.each do |lec|
      readeds.each do |r|
        if r.lecture_id == lec.id
          r.destroy
        end
      end
    end
  end

  def destroy_responses(course)
    responses = Response.where(user_id: current_user.id)
    course.testings.each do |t|
      t.questions.each do |q|
        responses.each do |r|
          if r.question_id == q.id
            r.destroy
          end
        end
      end
    end
  end

end
