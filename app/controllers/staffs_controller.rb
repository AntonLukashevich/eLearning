class StaffsController < ApplicationController
  def index
    @organization = Organization.find(params[:organization_id])
    @staffs = @organization.staffs
  end

  def new
    @organization = Organization.find(params[:organization_id])
    @staff = Staff.new
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @staff = @organization.staffs.build(staff_params)
    respond_to do |format|
      if @staff.save
        format.js
        format.html{ redirect_to organization_staffs_path(@organization), success: 'The users added to organization'}
        format.json
      end
    end
  end

  def destroy
    @organization = Organization.find(params[:organization_id])
    @staff = Staff.find(params[:id])
    @staff.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to organization_staffs_path(@organization), info: 'The user removed!' }
      format.json
    end

  end

  private

  def staff_params
    params.require(:staff).permit(:email, :registered)
  end
end
