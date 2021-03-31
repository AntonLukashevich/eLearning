# frozen_string_literal: true

class CreateResponses < ActiveRecord::Migration[6.1]
  # def change
  #   create_table :responses do |t|
  #     t.integer :mark
  #     t.string :response
  #     t.references :question, null: false, foreign_key: true
  #     t.references :user, null: false, foreign_key: true
  #     t.timestamps
  #   end
  # end

  def up
    create_table :responses do |t|
      t.integer :mark
      t.string :response
      t.references :question, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :responses
  end
end
