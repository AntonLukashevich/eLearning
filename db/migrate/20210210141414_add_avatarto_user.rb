class AddAvatartoUser < ActiveRecord::Migration[6.1]
  # def change
  # end

  def up
    add_column :users, :avatar, :string
  end

  def down
    remove_column :users, :avatar
  end
end
