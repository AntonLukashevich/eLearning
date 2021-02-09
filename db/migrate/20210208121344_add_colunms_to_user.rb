class AddColunmsToUser < ActiveRecord::Migration[6.1]
  # def change
  #   add_reference :users, :role, null: false, foreign_key: true
  #   add_reference :users, :organization, null: true, foreign_key: true
  # end

  def up
    add_reference :users, :role, null: false, foreign_key: true
    add_reference :users, :organization, null: true, foreign_key: true
  end

  def down
    remove_column :users, :role_id
    remove_column :users, :organization_id
  end

end
