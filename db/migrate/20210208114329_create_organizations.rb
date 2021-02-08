class CreateOrganizations < ActiveRecord::Migration[6.1]
  # def change
  #   create_table :organizations do |t|
  #     t.string :name
  #     t.text :description
  #
  #     t.timestamps
  #   end
  # end

  def up
    create_table :organizations do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def down
    drop_table :organizations
  end
end
