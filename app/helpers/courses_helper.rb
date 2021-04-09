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
    if user_signed_in?
      responses = Response.where(user_id: current_user.id)
    end
    count_answers = 0
    count_responses = 0
    questions = test.questions
    questions.each do |q|
      count_answers += q.answers.where(isCorrect: true).size
      if responses.present?
        responses.each do |r|
          if (q.id == r.question_id && r.mark == 1) && r.present?
            count_responses += 1
          end
        end
      end
    end

    @result = (count_responses.to_f / count_answers) * 100
    return @result
  end

end
