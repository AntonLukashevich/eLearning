class LectureBlock < ApplicationRecord
  belongs_to :lecture, foreign_key: "course_block_id"
  has_rich_text :content

  #has_many :text_contents, class_name: 'TextContent'
end
