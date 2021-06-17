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

  def testing_progress(test)
    # amount of correct responses / amount of correct answer
    responses = Response.where(user_id: current_user.id) if user_signed_in?
    count_answers = 0
    count_responses = 0
    questions = test.questions
    questions.each do |q|
      count_answers += q.answers.where(isCorrect: true).size
      next if responses.blank?

      responses.each do |r|
        count_responses += 1 if (q.id == r.question_id && r.mark == 1) && r.present?
      end
    end

    @result = (count_responses.to_f / count_answers) * 100
    @result
  end
end
