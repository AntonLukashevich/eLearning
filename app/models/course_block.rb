class CourseBlock < ApplicationRecord
  belongs_to :course
  acts_as_list
end
