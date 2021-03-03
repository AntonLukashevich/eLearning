class CourseTest < CourseBlock
  belongs_to :course
  has_many :radio_questions, class_name: 'RadioQuestion', foreign_key: 'course_test_id', dependent: :delete_all
end
