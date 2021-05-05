class Organization < ApplicationRecord
  belongs_to :user
  has_many :managers
  has_many :staffs
  mount_uploader :image, ImageUploader
end
