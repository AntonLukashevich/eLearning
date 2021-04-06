# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :role
  has_and_belongs_to_many :courses # rubocop:todo Rails/HasAndBelongsToMany
  has_many :certificates # rubocop:todo Rails/HasManyOrHasOneDependent
  has_many :achievements # rubocop:todo Rails/HasManyOrHasOneDependent
  has_many :readeds # rubocop:todo Rails/HasManyOrHasOneDependent
  has_many :responses # rubocop:todo Rails/HasManyOrHasOneDependent

  mount_uploader :avatar, AvatarUploader

  validates :first_name, :last_name, presence: true, length: { minimum: 2 }
  
end
