class AddColumnsToCourseBlock < ActiveRecord::Migration[6.1]
  def change
    add_column :course_blocks, :title, :string
    add_column :course_blocks, :description, :text
  end

end
