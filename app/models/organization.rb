class Organization < ApplicationRecord
  belongs_to :user
  has_many :managers
  has_many :staffs
  has_many :org_courses
  mount_uploader :image, ImageUploader


  def self.search_by(search_term)
    where("lower(title) LIKE :search_term", search_term: "%#{search_term.downcase}%")
  end
end
