class Lecture < ApplicationRecord
  belongs_to :course
  has_many :readeds, dependent:  :delete_all
  # has_many :lecture_blocks, class_name: 'LectureBlock', foreign_key: 'lecture_id', dependent: :delete_all
  acts_as_list
  has_rich_text :content

  validates :title, presence: true
end
