# frozen_string_literal: true

class User < ApplicationRecord
  # after_commit :user_avatar, on: [:create, :update]
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
  has_many :room_users
  mount_uploader :avatar, AvatarUploader

  validates :first_name, :last_name, presence: true, length: { minimum: 2 }
  # after_commit :add_default_avatar, on: %i[create update]

  @@role = Role.where(name: 'admin').first
  scope :followers, -> { where.not(role_id: @@role.id) }

  def gravatar_url
    # gravatar_id = Digest::MD5::hexdigest(email).downcase
    # "https://gravatar.com/avatar/#{gravatar_id}.png"
    'user.email'
  end

  def user_avatar(user, size=40)
    if user.avatar
      user.avatar.variant(resize: "#{size}x#{size}")
    else

    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def add_default_avatar
    if  avatar.nil?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'asserts', 'images', 'default-avatar.png'
          )
        ), filename: 'default-avatar.png',
        content_type: 'image/png'
      )
    end
  end

  def self.search_by(search_term)
    where(
      'lower(email) LIKE :search_term OR lower(first_name) LIKE :search_term OR lower(last_name) LIKE :search_term', search_term: "%#{search_term.downcase}%"
    )
  end
end
