class AddPositionToCourseBlock < ActiveRecord::Migration[6.1]
  def change
    add_column :course_blocks, :position, :integer
  end
end
