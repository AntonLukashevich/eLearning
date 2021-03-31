# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :users # rubocop:todo Rails/HasManyOrHasOneDependent
  validates :name, presence: true, length: { minimum: 3 }
end
