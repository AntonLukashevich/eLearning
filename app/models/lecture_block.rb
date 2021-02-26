class LectureBlock < ApplicationRecord
  belongs_to :lecture, class_name: 'Lecture'
  has_rich_text :content
end
