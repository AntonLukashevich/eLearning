# frozen_string_literal: true

module AchievementsHelper # rubocop:todo Style/Documentation
  def course_stats(course)

    lectures = course.lectures
    lectures_count = readed_lectures(lectures)

    if lectures.size > 0
      lecture_progress = 100* (lectures_count.to_f/ lectures.size)
    else
      lecture_progress = 100
    end

    testings = course.testings.includes(:questions)
    responses_count, full_count_questions = passed_tests(testings)
    if full_count_questions > 0
      test_progress = 100 * (responses_count.to_f/ full_count_questions)
    else
      test_progress = 100
    end

    current_progress = (test_progress + lecture_progress)/2

    ach = course.achievements.find_by(user_id: current_user.id)
    ach.update(progress: current_progress)


    [lecture_progress.to_i, test_progress.to_i]
  end


  private

  # amount readed lectures by current user
  def readed_lectures(lectures)
    count = 0
    readeds = Readed.where(user_id: current_user.id)
    lectures.each do |lec|
      readeds.each do |r|
        count += 1 if r.lecture_id == lec.id
      end
    end
    return count
  end

  # current user's testing stats
  def passed_tests(testings)
    all_questions = []
    full_count_questions = 0

    testings.each do |t|
      all_questions << t.questions
      full_count_questions += all_current_answers(t)
    end
    all_questions.flatten!

    responses_count = all_current_responses(all_questions)

    return [responses_count, full_count_questions]
  end

  # amount of correct test answers from all testings
  def all_current_answers(testing)

    count = 0
    testing.questions.each do |q|
      count += q.answers.where(isCorrect: true).size
    end
    return count
  end

  # amount of correct test answers by user
  def all_current_responses(questions)
    responses = Response.where(user_id: current_user.id)
    count = 0
    questions.each do |q|
      responses.each do |r|
        if (q.id == r.question_id && r.mark == 1)
          count +=1
        end
      end
    end
    return count
  end


end

