class AdminsController < ApplicationController

  def index
    @role = Role.where(name: 'admin').first
    @admins = User.where(role_id: @role.id)
  end

  def nominate
    @user = User.find(params[:id])
    @admin_role = Role.where(name: 'admin').first
    @user.update(role_id: @admin_role.id)
    redirect_to action: :index
  end

  def fire
    @user = User.find(params[:id])
    @user_role = Role.where(name: 'user').first
    @user.update(role_id: @user_role.id)
    redirect_to action: :index
  end

  def organizations
    @organizations = Organization.where(status: 'awaiting')
  end



  def users
    @users = User.includes(:role, :achievements, :certificates, :courses).where(role_id: 1)
  end

  def courses
    @courses = Course.includes(:achievements, :testings, :lectures, :users)
  end

end
