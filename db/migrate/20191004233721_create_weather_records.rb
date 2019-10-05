class CreateWeatherRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :weather_records do |t|
      t.date :date
      t.text :report
      t.references :high_level_location, foreign_key: true

      t.timestamps
    end
  end
end
