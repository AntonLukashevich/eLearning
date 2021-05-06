class CreateOrgCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :org_courses do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
