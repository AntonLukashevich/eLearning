# frozen_string_literal: true

module TestingsHelper # rubocop:todo Style/Documentation
  def author?(course)
    course.users.each do |user|
      if user.id == current_user.id
        return true
      else
        return false
      end
    end
  end
end
