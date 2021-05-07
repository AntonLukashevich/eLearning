class OrganizationMailer < ApplicationMailer

  def confirm_email
    @organization = params[:organization]
    @user = @organization.user
    mail(to: @user.email,
         subject: "Your request to create organization: #{@organization.title} confirmed")
  end

  def reject_email
    @organization = params[:organization]
    @user = organization.user
    mail(to: @user.email,
         subject: "Your request to create organization: #{@organization.title} rejected")
  end
end
