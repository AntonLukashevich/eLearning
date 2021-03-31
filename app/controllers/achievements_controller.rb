# frozen_string_literal: true

class AchievementsController < ApplicationController # rubocop:todo Style/Documentation
  def index
    @achievements = Achievement.where(user_id: current_user).includes(:user, :course)
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
    @achievement.destroy
    redirect_to courses_path
  end

  private

  def achievement_params
    params.require(:achievement).permit(:process, :user_id, :course_id)
  end
end
