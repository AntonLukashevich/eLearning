class Lecture < CourseBlock
  belongs_to :course
  has_many :lecture_blocks, class_name: 'LectureBlock', foreign_key: 'lecture_id', dependent: :delete_all
end
