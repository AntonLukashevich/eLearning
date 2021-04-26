class RatingWorker
  include Sidekiq::Worker

  def perform(achievement_id)
    achievement = Achievement.find(achievement_id.to_i)
    course = Course.find(achievement.course_id)
    rating = course.rating + achievement.rating
    course.update(rating: rating)
  end
end