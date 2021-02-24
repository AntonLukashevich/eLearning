class AddLectureKeyToLectureBlock < ActiveRecord::Migration[6.1]
  def change
    add_reference :lecture_blocks, :course_block, null: false, foreign_key: true
  end
end
