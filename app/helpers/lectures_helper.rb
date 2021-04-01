# frozen_string_literal: true

module LecturesHelper # rubocop:todo Style/Documentation
  def author?(course)
    course.users.each do |usr|
      if usr.id == current_user.id
        return true
      else
        return false
      end
    end
  end
end
