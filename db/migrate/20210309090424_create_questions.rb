class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :type_question
      t.text :question
      t.references :testing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
