# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'support@elearching.com'
  layout 'mailer'
end
