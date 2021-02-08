class User < ApplicationRecord
  belongs_to :role
  belongs_to :organization


  has_many :course_authors
  has_many :user_courses_lists
  has_many :certificates
end
