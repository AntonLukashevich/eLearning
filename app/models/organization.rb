class Organization < ApplicationRecord
  belongs_to :user
  has_many :managers
  mount_uploader :image, ImageUploader
end
