# frozen_string_literal: true

class RequestToPublishCourseWorker
  include Sidekiq::Worker

  def perform(course_id)
    for_publication_course = Course.find(course_id.to_i)
    for_publication_course.update(status: 'for_publication')
  end
end
