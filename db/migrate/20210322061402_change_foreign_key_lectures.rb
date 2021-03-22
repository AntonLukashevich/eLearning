class ChangeForeignKeyLectures < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :lectures, column: :course_block_id
    add_reference :lectures, :course, index: true
  end
end
