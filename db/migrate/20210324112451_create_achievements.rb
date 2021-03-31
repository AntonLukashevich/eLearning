# frozen_string_literal: true

class CreateAchievements < ActiveRecord::Migration[6.1]
  # def change
  #   create_table :achievements do |t|
  #     t.integer :progress
  #     t.references :user, null: false, foreign_key: true
  #     t.references :course, null: false, foreign_key: true
  #     t.timestamps
  #   end
  # end

  def up
    create_table :achievements do |t|
      t.integer :progress
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :achievements
  end
end
