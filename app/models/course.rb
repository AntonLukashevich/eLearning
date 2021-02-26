class Course < ApplicationRecord
  has_and_belongs_to_many :users
  has_one :certificate
  has_many :user_courses_lists
  has_many :course_blocks
  has_many :lectures , dependent:  :delete_all
  has_many :text_contents

  mount_uploader :image, ImageUploader

  validates :description, length: {maximum: 10, maximum: 500}
end
