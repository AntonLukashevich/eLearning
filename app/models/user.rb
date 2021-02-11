class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :role
  belongs_to :course_authors
  has_many :user_courses_lists
  has_many :certificates

  mount_uploader :avatar, AvatarUploader




end
