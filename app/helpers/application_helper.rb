# frozen_string_literal: true

module ApplicationHelper # rubocop:todo Style/Documentation
  def gravatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email).downcase
    url = "https://gravatar.com/avatar/#{gravatar_id}.png"
  end
end
