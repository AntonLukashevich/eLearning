class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :role
  has_and_belongs_to_many :courses
  has_many :certificates
  has_many :achievements
  has_many :readeds

  mount_uploader :avatar, AvatarUploader

  validates :first_name, presence: true, length: {minimum: 2}
end

