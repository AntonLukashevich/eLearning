class CreateLectureBlocks < ActiveRecord::Migration[6.1]
  # def change
  #   create_table :lecture_blocks do |t|
  #     t.string :title
  #     t.string :type
  #     t.integer :order
  #     t.references :lecture, null: false, foreign_key: true
  #
  #     t.timestamps
  #   end
  # end

  def up
    create_table :lecture_blocks do |t|
      t.string :title
      t.references :lecture #, foreign_key: { to_table: :course_blocks}
      t.references :test #, foreign_key: { to_table: :course_blocks}
      t.timestamps
    end

    add_foreign_key :lecture_blocks, :course_blocks, column: :lecture_id
    add_foreign_key :lecture_blocks, :course_blocks, column: :test_id
  end

  def down
    drop_table :lecture_blocks
  end
end
