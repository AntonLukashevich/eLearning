class Course < ApplicationRecord
  belongs_to :course_author
  accepts_nested_attributes_for :course_author, allow_destroy: true


  has_one :certificate
  has_many :user_courses_lists
  has_many :course_blocks
  has_many :video_contents
  has_many :image_contents
  has_many :text_contents


end
