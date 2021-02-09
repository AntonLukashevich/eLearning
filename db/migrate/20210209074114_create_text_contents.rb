class CreateTextContents < ActiveRecord::Migration[6.1]
  # def change
  #   create_table :text_contents do |t|
  #     t.text :text
  #     t.references :lecture_block, null: false, foreign_key: true
  #
  #     t.timestamps
  #   end
  # end

  def up
    create_table :text_contents do |t|
      t.text :text
      t.references :lecture_block, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :text_contents
  end
end
