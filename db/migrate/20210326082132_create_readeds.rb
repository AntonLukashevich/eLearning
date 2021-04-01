# frozen_string_literal: true

class CreateReadeds < ActiveRecord::Migration[6.1]
  # def change
  #   create_table :readeds do |t|
  #     t.references :lecture, null: false, foreign_key: true
  #     t.references :user, null: false, foreign_key: true
  #     t.boolean :is_readed
  #
  #     t.timestamps
  #   end
  # end

  def up
    create_table :readeds do |t|
      t.references :lecture, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :is_readed

      t.timestamps
    end
  end

  def down
    drop_table :readeds
  end
end
