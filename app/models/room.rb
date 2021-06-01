class Room < ApplicationRecord
  has_many :room_messages, dependent: :destroy
  has_many :room_users
end
