class OrganizationRegistrationWorker
  include Sidekiq::Worker

  def perform(organization_id, response_status)
    organization = Organization.find(organization_id.to_i)
    organization.update(status: response_status.to_s)
  end
end