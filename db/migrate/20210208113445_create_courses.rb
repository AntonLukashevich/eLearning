# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[6.1] # rubocop:todo Style/Documentation
  # def change
  #   create_table :courses do |t|
  #     t.string :title
  #     t.text :description
  #     t.string :status
  #     t.string :type_course
  #     t.integer :rating
  #
  #     t.timestamps
  #   end
  # end

  def up
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.string :status
      t.string :type_course
      t.integer :rating

      t.timestamps
    end
  end

  def down
    drop_table :courses
  end
end
