# frozen_string_literal: true

module CoursesHelper # rubocop:todo Style/Documentation
  def subscribe?(user_id, course_id)
    Achievement.where(:user_id => user_id, :course_id => course_id).first.present?
  end
end
