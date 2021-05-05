class CreateStaffs < ActiveRecord::Migration[6.1]
  def change
    create_table :staffs do |t|
      t.string :email
      t.references :organization, null: false, foreign_key: true
      t.boolean :registered

      t.timestamps
    end
  end
end
