class Question < ApplicationRecord
  belongs_to :testing

  has_many :answers
  accepts_nested_attributes_for :answers, allow_destroy: true

  has_rich_text :content
end
