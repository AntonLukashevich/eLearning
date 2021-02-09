class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  belongs_to :role
  belongs_to :organization


  has_many :course_authors
  has_many :user_courses_lists
  has_many :certificates


  # after_create :default_role
  #
  # private
  # def default_role
  #   self.role << Role.where(:name => 'user').first.id
  # end

end
