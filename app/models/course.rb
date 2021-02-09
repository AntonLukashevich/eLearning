class Course < ApplicationRecord
  has_many :course_authors
  has_many :user_courses_lists

  has_one :certificate

  has_many :course_blocks
  has_many :video_contents
  has_many :image_contents
  has_many :text_contents
end
