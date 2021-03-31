# frozen_string_literal: true

class AddAvatartoUser < ActiveRecord::Migration[6.1] # rubocop:todo Style/Documentation
  # def change
  # end

  def up
    add_column :users, :avatar, :string
  end

  def down
    remove_column :users, :avatar
  end
end
