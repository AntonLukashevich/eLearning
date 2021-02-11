class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]


  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def create
    #binding.pry
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
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

    permitted = params.require(:course).permit(:title)
    permitted.merge!(role_id: Role.where(name: 'user').last.id)
  end

  def set_user
    @user= User.find(params[:id])
  end

end
