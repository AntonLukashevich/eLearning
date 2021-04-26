class AddRatingToAchievement < ActiveRecord::Migration[6.1]
  def up
    add_column :achievements, :rating, :integer, default: 0
  end

  def down
    remove_column :achievements, :rating
  end
end
