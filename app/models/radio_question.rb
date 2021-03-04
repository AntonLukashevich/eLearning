class RadioQuestion < Question
  belongs_to :course_test, class_name: 'CourseTest'

  has_many :answers , inverse_of: :question
  accepts_nested_attributes_for :answers, allow_destroy: true
end
