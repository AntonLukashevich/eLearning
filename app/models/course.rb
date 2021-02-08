class Course < ApplicationRecord
  has_many :course_authors
  has_many :user_courses_lists

  has_one :certificate
end
