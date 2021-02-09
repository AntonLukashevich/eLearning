class Lecture < ApplicationRecord
  belongs_to :course_block

  has_many :lecture_blocks
end
