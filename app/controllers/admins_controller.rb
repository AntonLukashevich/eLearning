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
    @request_organizations = Organization.includes(:user).where.not(status: 'confirmed')
    @organizations = Organization.includes(:staffs, :managers).where(status: 'confirmed')
  end



  def users
    @role = Role.where(name: 'user').first
    @users = User.includes(:achievements, :certificates, :courses, :organizations).where(role_id: @role.id)
  end

  def courses
    @courses = Course.includes(:achievements, :testings, :lectures, :users)
  end

end
