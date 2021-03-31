# frozen_string_literal: true

class CreatePictures < ActiveRecord::Migration[6.1]
  # def change
  #   create_table :pictures do |t|
  #     t.string :picture
  #     t.timestamps
  #   end
  # end

  def up
    create_table :pictures do |t|
      t.string :picture
      t.timestamps
    end
  end

  def down
    drop_table :pictures
  end
end
