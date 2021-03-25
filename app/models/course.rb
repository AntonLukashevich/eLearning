class Course < ApplicationRecord
  include ActiveModel::AttributeAssignment
  has_and_belongs_to_many :users
  has_one :certificate
  has_many :lectures , dependent:  :delete_all
  has_many :testings , dependent:  :delete_all
  has_many :achievements

  mount_uploader :image, ImageUploader

  #validates :description, length: {maximum: 500, maximum: 10}
   validates :title, presence: true, length: {minimum: 2}

end
