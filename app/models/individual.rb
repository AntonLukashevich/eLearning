# frozen_string_literal: true

class Individual < ApplicationRecord
  belongs_to :course
  belongs_to :user
end
