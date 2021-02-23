class Course < ApplicationRecord

  has_and_belongs_to_many :users

  has_one :certificate
  has_many :user_courses_lists
  has_many :course_blocks
  has_many :text_contents

end
