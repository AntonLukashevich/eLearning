class ChangeLectureBlock < ActiveRecord::Migration[6.1]
  def change
    remove_column :lecture_blocks, :type
    remove_column :lecture_blocks, :order
    remove_column :lecture_blocks,  :lecture_id, index: true, foreign_key: true
  end
end
