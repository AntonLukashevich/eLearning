class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :type
      t.text :question
      t.references :course_test

      t.timestamps
    end
    add_foreign_key :questions, :course_blocks, column: :course_test_id
  end
end
