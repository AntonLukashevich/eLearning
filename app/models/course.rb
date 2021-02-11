class Course < ApplicationRecord
  #after_create :add_course_author_to_authors_table

  belongs_to :course_author
  #accepts_nested_attributes_for :course_author, allow_destroy: true


  has_one :certificate
  has_many :user_courses_lists
  has_many :course_blocks
  has_many :video_contents
  has_many :image_contents
  has_many :text_contents


  # private
  # def add_course_author_to_authors_table
  #   @course_author = CourseAuthor.create(user_id: User.find_by(id: session[:user_id]), course_id: Course.last.id)
  #   binding.pry
  #   @course_author.save
  # end

end
