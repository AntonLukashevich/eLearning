# frozen_string_literal: true

module CoursesHelper # rubocop:todo Style/Documentation
  def subscribe?(user, course)
    Achievement.where(user_id: user, course_id: course).first.present?

    # course.achievements.each do |a|
    #   #binding.pry
    #   if a.user_id == current_user.id && a.course_id == course.id
    #     return true
    #   else
    #     return false
    #   end
    # end
  end
end
