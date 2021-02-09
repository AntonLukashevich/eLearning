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
      t.string :type
      t.integer :order
      t.references :lecture, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :lecture_blocks
  end
end
