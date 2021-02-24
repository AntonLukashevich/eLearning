class LectureBlock < ApplicationRecord
  belongs_to :lecture, class_name: "CourseBlock", foreign_key: :lecture_id
  has_rich_text :content

  #has_many :text_contents, class_name: 'TextContent'
end
