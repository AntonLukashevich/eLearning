class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.string :answer
      t.boolean :isCorrect
      t.references :question

      t.timestamps
    end
    #add_foreign_key :answers, :questions,
  end
end
