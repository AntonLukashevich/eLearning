# frozen_string_literal: true

class AdminsController < ApplicationController
  helper_method :sort_column, :sort_direction, :course_sort_column, :course_sort_direction

  def index
    @role = Role.where(name: 'admin').first
    @admins = User.includes(:courses, :achievements, :certificates, :organizations).where(role_id: @role.id)
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

    if params[:search]
      @search_term = params[:search]
      @organizations = @organizations.search_by(@search_term)
    else
      @organizations #= User.includes(:achievements, :certificates, :courses, :organizations).where(role_id: @role.id)
    end
  end

  def users
    @role = Role.where(name: 'user').first
    @users = User.includes(:achievements, :certificates, :courses,
                           :organizations).where(role_id: @role.id).order("#{sort_column} #{sort_direction}")

    if params[:search]
      @search_term = params[:search]
      @users = @users.search_by(@search_term)
    else
      @users #= User.includes(:achievements, :certificates, :courses, :organizations).where(role_id: @role.id)
    end
  end

  def courses
    @courses = Course.includes(:achievements, :testings, :lectures, :users,
                               :certificate).order("#{course_sort_column} #{course_sort_direction}")

    if params[:search]
      @search_term = params[:search]
      @courses = @courses.search_by(@search_term)
    else
      @courses #= User.includes(:achievements, :certificates, :courses, :organizations).where(role_id: @role.id)
    end
  end

  private

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def course_sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def course_sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
