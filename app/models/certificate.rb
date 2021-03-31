# frozen_string_literal: true

class Certificate < ApplicationRecord
  belongs_to :user
  belongs_to :course
end
