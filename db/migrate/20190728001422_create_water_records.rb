class CreateWaterRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :water_records do |t|
      t.belongs_to :plant_instance, foreign_key: true
      t.datetime :moment
      t.decimal :ounces

      t.timestamps
    end
  end
end
