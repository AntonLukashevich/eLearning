class CreateResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :responses do |t|
      t.integer :mark
      t.string :response
      t.references :question, null: false, foreign_key: true
      t.timestamps
    end
  end
end
