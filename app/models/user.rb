# frozen_string_literal: true

class User < ApplicationRecord
  #after_commit :user_avatar, on: [:create, :update]
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
  has_many :individuals
  has_many :organizations
  has_many :managers
  has_many :room_messages
  mount_uploader :avatar, AvatarUploader

  validates :first_name, :last_name, presence: true, length: { minimum: 2 }

  @@role = Role.where(name: 'admin').first
  scope :followers, -> { where.not(role_id: @@role.id) }
end
