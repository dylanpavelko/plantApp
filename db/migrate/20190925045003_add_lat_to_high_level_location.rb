class AddLatToHighLevelLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :high_level_locations, :lat, :decimal
  end
end
