# frozen_string_literal: true

class CreateRoles < ActiveRecord::Migration[6.1] # rubocop:todo Style/Documentation
  # def change
  #   create_table :roles do |t|
  #     t.string :name
  #
  #     t.timestamps
  #   end
  # end

  def up
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :roles
  end
end
