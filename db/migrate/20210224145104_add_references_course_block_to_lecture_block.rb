class AddReferencesCourseBlockToLectureBlock < ActiveRecord::Migration[6.1]
  def change
    add_reference :lecture_blocks, :course_block, null: false, foreign_key: true, foreign_key_name: :lecture_id
  end
end
