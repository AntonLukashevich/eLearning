class Organization < ApplicationRecord
  belongs_to :user
  has_many :managers
  has_many :staffs
  has_many :org_courses
  mount_uploader :image, ImageUploader
end
