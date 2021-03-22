class DeleteForeignKeyLectures < ActiveRecord::Migration[6.1]
  def change
    remove_reference :lectures, :course_block, index: true
  end
end
