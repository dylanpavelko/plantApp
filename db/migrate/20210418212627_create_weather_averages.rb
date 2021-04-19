class CreateWeatherAverages < ActiveRecord::Migration[5.2]
  def change
    create_table :weather_averages do |t|
      t.integer :day
      t.references :high_level_location, foreign_key: true
      t.decimal :max_temp_f
      t.decimal :min_temp_f
      t.decimal :precip_in
      t.decimal :max_t_std_dev
      t.decimal :min_t_std_dev
      t.decimal :precip_std_dev

      t.timestamps
    end
  end
end
