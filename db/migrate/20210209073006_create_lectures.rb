# frozen_string_literal: true

class CreateLectures < ActiveRecord::Migration[6.1] # rubocop:todo Style/Documentation
  # def change
  #   create_table :lectures do |t|
  #     t.string :title
  #     t.text :description
  #     t.references :course_block, null: false, foreign_key: true
  #
  #     t.timestamps
  #   end
  # end

  def up
    create_table :lectures do |t|
      t.string :title
      t.text :description
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :lectures
  end
end
