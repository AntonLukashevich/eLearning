# frozen_string_literal: true

module AchievementsHelper # rubocop:todo Style/Documentation

  def lectures(course)
    course.lectures.count
  end

  def readed_lectures(course)
    @user = current_user

    lectures = course.lectures
    amount =  0

    readeds = Readed.includes(:lecture).where(user_id: @user.id)

    #binding.pry

    lectures.each do |lec|
      #binding.pry
        readeds.each do |r|
        if r.lecture_id == lec.id
          amount +=1
        end
      end
    end

    return amount
  end

end
