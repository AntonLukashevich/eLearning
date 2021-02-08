class CreateCertificates < ActiveRecord::Migration[6.1]
  # def change
  #   create_table :certificates do |t|
  #     t.string :title
  #     t.date :date_graduation
  #
  #     t.references :user, null: false, foreign_key: true
  #     t.references :course, null: false, foreign_key: true
  #
  #     t.timestamps
  #   end
  # end

  def up
    create_table :certificates do |t|
      t.string :title
      t.date :date_graduation

      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :certificates
  end
end
