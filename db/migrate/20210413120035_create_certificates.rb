# frozen_string_literal: true

class CreateCertificates < ActiveRecord::Migration[6.1]
  def change
    create_table :certificates do |t|
      t.string :result
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
