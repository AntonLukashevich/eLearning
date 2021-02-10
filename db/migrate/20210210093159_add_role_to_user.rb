class AddRoleToUser < ActiveRecord::Migration[6.1]
  # def change
  # add_reference :users, :role_id, foreign_key: true
  # end

  def up
    add_reference :users, :role, foreign_key: true
  end

  def down
    remove_reference :users, :role
  end
end
