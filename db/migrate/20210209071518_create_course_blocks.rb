class CreateCourseBlocks < ActiveRecord::Migration[6.1]
  # def change
  #   create_table :course_blocks do |t|
  #     t.integer :order
  #     t.string :type
  #
  #     t.references :course, null: false, foreign_key: true
  #
  #     t.timestamps
  #   end
  # end

  def up
    create_table :course_blocks do |t|
      t.string :title
      t.text :description
      t.integer :position
      t.references :course, null: false, foreign_key: true
      #t.references :course_blockble, polymorhpic: true
      t.timestamps
    end
  end

  def down
    drop_table :course_blocks
  end
end
