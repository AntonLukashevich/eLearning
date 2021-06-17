# frozen_string_literal: true

class Testing < ApplicationRecord
  belongs_to :course
  has_many :questions, dependent: :destroy

  validates :title, presence: true
end
