# frozen_string_literal: true

module AchievementsHelper # rubocop:todo Style/Documentation
  def lectures_stats(course)
    lectures = course.lectures
    testings = course.testings

    lectures_count = 0
    readeds = Readed.where(user_id: current_user.id)
    lectures.each do |lec|
      readeds.each do |r|
        lectures_count += 1 if r.lecture_id == lec.id
      end
    end

    full_lectures_count = lectures.size
    full_testings_count = testings.size
    progress = full_lectures_count + full_testings_count

    [lectures_count, progress]
  end
end
