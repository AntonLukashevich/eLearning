class Lecture < CourseBlock
  belongs_to :course

  has_many :lecture_blocks
end
