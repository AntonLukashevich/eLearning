# frozen_string_literal: true

class UsersController < ApplicationController # rubocop:todo Style/Documentation
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all.includes(:achievements)
  end

  def new
    @user = User.new
  end

  def show
    @user_courses = User.find(params[:id]).courses
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    permitted = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,
                                             :role_id, :avatar)

    permitted.merge!(role_id: Role.where(name: 'user').last.id)
  end

  def set_user
    @user ||= User.find(params[:id])
  end
end
