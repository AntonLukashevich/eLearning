# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[6.1]
  # def change
  #   create_table :answers do |t|
  #     t.text :answer
  #     t.boolean :isCorrect
  #     t.integer :position
  #     t.references :question, null: false, foreign_key: true
  #
  #     t.timestamps
  #   end
  # end

  def up
    create_table :answers do |t|
      t.text :answer
      t.boolean :isCorrect
      t.integer :position
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :answers
  end
end
