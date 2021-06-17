# frozen_string_literal: true

class Manager < ApplicationRecord
  belongs_to :organization
  belongs_to :user
end
