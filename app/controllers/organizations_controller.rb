# frozen_string_literal: true

class OrganizationsController < ApplicationController # rubocop:todo Style/Documentation
  before_action :set_organization, only: %i[show edit update destroy]
  def index
    @organizations = Organization.all
  end

  def show

  end

  def new
    if user_signed_in?
      @organization = Organization.new
    end
  end

  def create
    @organization = current_user.organizations.build(org_params)
    @organization.status = 'awaiting'
    if @organization.save
      redirect_to organizations_path, success: "Application sent! Wait admin response."
    else
      render 'new', danger: 'Error! Something went wrong... Check your input info.'
    end
  end

  def response
    @organization = Organization.find(params[:id])
    #binding.pry
    #redirect_to organizations_path
  end

  private

  def org_params
    params.require(:organization).permit(:title, :description, :status, :user_id, :purpose)
  end

  def set_organization
    @organization = Organization.find(params[:id])
  end
end
