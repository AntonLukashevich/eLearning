class Course < ApplicationRecord
  has_and_belongs_to_many :users
  has_one :certificate
  has_many :user_courses_lists
  has_many :lectures , dependent:  :delete_all
  has_many :testings , dependent:  :delete_all

  mount_uploader :image, ImageUploader

  #validates :description, length: {maximum: 500, maximum: 10}
end
