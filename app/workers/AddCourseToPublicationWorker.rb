class AddCourseToPublicationWorker
  include Sidekiq::Worker
  #@course.update(status: 'ready')

  def perform(course_id)
    for_publication_course = Course.find(course_id.to_i)
    for_publication_course.update(status: 'ready')
  end
end