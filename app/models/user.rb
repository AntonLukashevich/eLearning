class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :role
  has_and_belongs_to_many :courses
  has_many :user_courses_lists
  has_many :certificates

  mount_uploader :avatar, AvatarUploader

  validates :first_name, presence: true, length: {minimum: 2}
end

