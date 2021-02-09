class CreateImageContents < ActiveRecord::Migration[6.1]
  # def change
  #   create_table :image_contents do |t|
  #     t.string :image
  #     t.references :lecture_block, null: false, foreign_key: true
  #
  #     t.timestamps
  #   end
  # end

  def up
    create_table :image_contents do |t|
      t.string :image
      t.references :lecture_block, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :image_contents
  end
end
