# frozen_string_literal: true

class AddImageToCourse < ActiveRecord::Migration[6.1]
  # def change
  #   add_column :courses, :image, :string
  # end

  def up
    add_column :courses, :image, :string
  end

  def down
    remove_column :courses, :image
  end

end
