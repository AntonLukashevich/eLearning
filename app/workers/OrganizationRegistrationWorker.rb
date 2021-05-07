class OrganizationRegistrationWorker
  include Sidekiq::Worker

  def perform(organization_id, response_status)
    @organization = Organization.find(organization_id.to_i)
    @organization.update(status: response_status.to_s)

    if response_status == 'confirmed'
      OrganizationMailer.with(organization: @organization).confirm_email.deliver_now
    else
      OrganizationMailer.with(organization: @organization).reject_email.deliver_now
    end
  end
end