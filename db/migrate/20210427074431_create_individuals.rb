class CreateIndividuals < ActiveRecord::Migration[6.1]
  # def change
  #   create_table :individuals do |t|
  #     t.references :user, null: false, foreign_key: true
  #     t.references :course, null: false, foreign_key: true
  #     t.timestamps
  #   end
  # end

  def up
    create_table :individuals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :individuals
  end
end
