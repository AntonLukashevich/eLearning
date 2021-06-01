class StaffsController < ApplicationController
  before_action :set_organization, only: %i[index new create destroy]

  def index
    @staffs = @organization.staffs
  end

  def new
    @staff = Staff.new
  end

  def create
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

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end
end
