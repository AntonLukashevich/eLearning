# frozen_string_literal: true

class AddPositionToLecture < ActiveRecord::Migration[6.1]
  # def change
  #   add_column :lectures, :position, :integer
  # end

  def up
    add_column :lectures, :position, :integer
  end

  def down
    remove_column :lectures, :position
  end
end
