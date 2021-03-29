class Question < ApplicationRecord
  belongs_to :testing
  has_many :answers, dependent: :destroy
  has_many :responses
  has_rich_text :content

  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :question, presence: true
end
