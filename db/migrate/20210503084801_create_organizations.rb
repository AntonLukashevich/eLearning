# frozen_string_literal: true

class CreateOrganizations < ActiveRecord::Migration[6.1]
  def up
    create_table :organizations do |t|
      t.string :title
      t.string :description
      t.string :purpose
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.string :image
      t.timestamps
    end
  end

  def down
    drop_table :organizations
  end
end
