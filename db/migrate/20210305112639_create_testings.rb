class CreateTestings < ActiveRecord::Migration[6.1]
  def change
    create_table :testings do |t|
      t.string :title
      t.text :description
      t.references :course, null: false, foreign_key: true
      t.timestamps
    end
  end
end
