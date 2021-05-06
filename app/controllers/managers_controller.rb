class ManagersController < ApplicationController
  def index
    @organization = Organization.find(params[:organization_id])
    @managers = @organization.managers
  end

  def new
    @organization = Organization.find(params[:organization_id])
    @manager = Manager.new
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @manager = @organization.managers.build(manager_params)
    respond_to do |format|
      if @manager.save
        format.js
        format.html{ redirect_to organization_managers_path(@organization), success: 'The manager added to organization'}
        format.json
      end
    end
  end

  def destroy
    @organization = Organization.find(params[:organization_id])
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
end
