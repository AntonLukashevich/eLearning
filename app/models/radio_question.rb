class RadioQuestion < Question
  belongs_to :course_test, class_name: 'CourseTest'
end
