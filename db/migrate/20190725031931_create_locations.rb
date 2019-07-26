class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.boolean :indoors
      t.belongs_to :high_level_location, foreign_key: true

      t.timestamps
    end
  end
end
