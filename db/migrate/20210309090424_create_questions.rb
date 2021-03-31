# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.1]
  # def change
  #   create_table :questions do |t|
  #     t.string :type_question
  #     t.text :question
  #     t.references :testing, null: false, foreign_key: true
  #
  #     t.timestamps
  #   end
  # end

  def up
    create_table :questions do |t|
      t.string :type_question
      t.text :question
      t.references :testing, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :questions
  end
end
