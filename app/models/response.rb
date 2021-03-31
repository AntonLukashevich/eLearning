# frozen_string_literal: true

class Response < ApplicationRecord
  belongs_to :question
  belongs_to :user
end
