class LectureBlock < ApplicationRecord
  belongs_to :lecture, class_name: 'Lecture'
  has_rich_text :content

  #has_many :text_contents, class_name: 'TextContent'
end
