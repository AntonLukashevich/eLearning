# frozen_string_literal: true

class OrganizationsController < ApplicationController # rubocop:todo Style/Documentation
  #before_action :set_organization, only: %i[show edit update destroy]
  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.includes(:managers, :staffs).find(params[:id])
    @managers = @organization.managers
    @staffs = @organization.staffs
  end

  def new
    if user_signed_in?
      @organization = Organization.new
    end
  end

  def create
    @organization = Organization.find(params[:id])
    @organization = current_user.organizations.build(org_params)
    @organization.status = 'awaiting'
    if @organization.save
      redirect_to organizations_path, success: "Application sent! Wait admin response."
    else
      render 'new', danger: 'Error! Something went wrong... Check your input info.'
    end
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update(org_params)
      redirect_to @organization, success: 'Changes saved.'
    else
      render 'edit', danger: 'Error! Something went wrong... Check your input info.'
    end
  end

  def response_to_request
    OrganizationRegistrationWorker.perform_async(params[:id],params[:response_status])
    # @organization = Organization.find(params[:id])
    # @organization.update(status: params[:response_status].to_s)
    redirect_to organizations_admins_path
  end

  private

  def org_params
    params.require(:organization).permit(:title, :description, :status, :user_id, :purpose, :image)
  end

  def set_organization
    @organization = Organization.find(params[:id])
  end
end
