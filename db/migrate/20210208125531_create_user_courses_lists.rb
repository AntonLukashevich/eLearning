class CreateUserCoursesLists < ActiveRecord::Migration[6.1]
  # def change
  #   create_table :user_courses_lists do |t|
  #     t.float :current_result
  #     t.boolean :certificate
  #     t.references :user, null: false, foreign_key: true
  #     t.references :course, null: false, foreign_key: true
  #
  #     t.timestamps
  #   end
  # end

  def up
    create_table :user_courses_lists do |t|
      t.float :current_result
      t.boolean :certificate
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :user_courses_lists
  end
end
