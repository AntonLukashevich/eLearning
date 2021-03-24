class RenameTypeColumnQuestion < ActiveRecord::Migration[6.1]
  def change
    rename_column :questions, :type, :type_question
  end
end
