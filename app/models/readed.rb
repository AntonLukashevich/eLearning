# frozen_string_literal: true

class Readed < ApplicationRecord
  belongs_to :lecture
  belongs_to :user
end
