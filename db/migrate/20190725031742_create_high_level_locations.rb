class CreateHighLevelLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :high_level_locations do |t|
      t.string :name
      t.string :zip

      t.timestamps
    end
  end
end
