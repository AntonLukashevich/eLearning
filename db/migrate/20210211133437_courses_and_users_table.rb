class CoursesAndUsersTable < ActiveRecord::Migration[6.1]

  def up
    create_table :users_courses, id: false do |t|
      t.belongs_to :user
      t.belongs_to :course
    end
  end

  def down
    drop_table :users_courses
  end
end
