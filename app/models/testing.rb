class Testing < ApplicationRecord
  belongs_to :course
  has_many :questions

  validates :title, presence: true
end
