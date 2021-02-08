class User < ApplicationRecord
  belongs_to :role
  belongs_to :organization

  has_many :course_authors
end
