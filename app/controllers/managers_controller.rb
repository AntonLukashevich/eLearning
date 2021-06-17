# frozen_string_literal: true

class ManagersController < ApplicationController
  before_action :set_organization, only: %i[index new create destroy]
  def index
    @managers = @organization.managers
  end

  def new
    @manager = Manager.new
  end

  def create
    @manager = @organization.managers.build(manager_params)
    respond_to do |format|
      if @manager.save
        format.js
        format.html do
          redirect_to organization_managers_path(@organization), success: 'The manager added to organization'
        end
        format.json
      end
    end
  end

  def destroy
    @manager = Manager.find(params[:id])
    @manager.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to organization_managers_path(@organization), info: 'The user removed!' }
      format.json
    end
  end

  private

  def manager_params
    params.require(:manager).permit(:user_id)
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end
end
