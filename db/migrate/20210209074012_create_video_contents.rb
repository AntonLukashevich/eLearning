class CreateVideoContents < ActiveRecord::Migration[6.1]
  # def change
  #   create_table :video_contents do |t|
  #     t.string :video
  #     t.references :lecture_block, null: false, foreign_key: true
  #
  #     t.timestamps
  #   end
  # end

  def up
    create_table :video_contents do |t|
      t.string :video
      t.references :lecture_block, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :video_contents
  end
end
