# frozen_string_literal: true

class Course < ApplicationRecord
  include ActiveModel::AttributeAssignment
  has_and_belongs_to_many :users # rubocop:todo Rails/HasAndBelongsToMany
  has_one :certificate # rubocop:todo Rails/HasManyOrHasOneDependent
  has_many :lectures, dependent:  :delete_all
  has_many :testings, dependent:  :delete_all
  has_many :achievements # rubocop:todo Rails/HasManyOrHasOneDependent
  has_many :individuals
  has_many :org_courses
  mount_uploader :image, ImageUploader

  # validates :description, length: {maximum: 500, maximum: 10}
  validates :title, presence: true, length: { minimum: 2 }

  scope :by_created_at, -> { order(created_at: :asc) }
  scope :by_last_created_at, -> { order(created_at: :desc) }
end
