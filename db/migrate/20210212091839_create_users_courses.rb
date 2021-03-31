# frozen_string_literal: true

class CreateUsersCourses < ActiveRecord::Migration[6.1] # rubocop:todo Style/Documentation
  # def change
  #   create_table :courses_users do |t| # rubocop:todo Rails/CreateTableWithTimestamps
  #     t.belongs_to :user
  #     t.belongs_to :course
  #   end
  # end

  def up
    create_table :courses_users do |t| # rubocop:todo Rails/CreateTableWithTimestamps
    t.belongs_to :user
    t.belongs_to :course
    end
  end

  def down
    drop_table :courses_users
  end
end
