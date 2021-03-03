class Question < ApplicationRecord
  belongs_to :course_test, class_name: 'CourseTest'
  has_many :answers
  accepts_nested_attributes_for :answers, allow_destroy: true
end
