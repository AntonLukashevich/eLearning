class LectureBlock < ApplicationRecord
  belongs_to :lecture

  has_many :text_contents, class_name: 'TextContent'
end
