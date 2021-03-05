class AddPositionToLecture < ActiveRecord::Migration[6.1]
  def change
    add_column :lectures, :position, :integer
  end
end
