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
      sign_in @user
      redirect_to user_path(@user), success: 'Your profile created'
    else
      render 'new', danger: 'Error! Something went wrong... Check your input info.'
    end
  end

  def update
    if @user.update(user_params)
      sign_in @user
      redirect_to @user, success: 'Your profile updated'
    else
      render 'edit', danger: 'Error! Something went wrong... Check your input info.'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, info: 'Profile deleted.'
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


  def user_avatar(user)
    user = current_user
    if user.avatar.nil?
      user.update[:avatar => 'default-avatar.jpeg']
    end
  end

end
